//
//  ViewController.swift
//  ParkALot
//
//  Created by Spencer Jolie on 1/24/20.
//  Copyright © 2020 Spencer Jolie. All rights reserved.
//

import UIKit
import SocketIO

struct Root : Decodable {
   let Garages: [Garage]
}
struct Garage: Decodable{
    let _id: String
    let garageName: String
    let address: String
    let carsInLot: Int
    let capacity: Int
    let createdAt: String
    let updatedAt: String
    let __v: Int
}

class ViewController: UIViewController {
    
    @IBOutlet weak var availableSpots: UILabel!
    @IBOutlet weak var track: UILabel!
    @IBOutlet weak var parking: UILabel!
    @IBOutlet var headerBacground: UIImageView!
    @IBOutlet var purpCon: UIImageView!
    @IBOutlet weak var garageName: UILabel!
    @IBOutlet weak var outOf: UILabel!
    @IBOutlet weak var opaqCon: UIImageView!
    @IBOutlet weak var goTo: UIButton!
    @IBAction func goToMap(_ sender: Any) {
        guard let urlButton = URL(string: "http://maps.apple.com/?address=1803+15th+avenue+south,+37212+Nashville,+tn&t=m") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(urlButton, options: [:]) {_ in }
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(urlButton)
        }
    }
    
    let manager = SocketManager(socketURL: URL(string: "https://park-a-lot.herokuapp.com/")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    var total: Int!
    var avail: Int!
    var taken: Int!
    var ttlAvl: String!
    var garageList:[Garage] = []
    var x = 0
    let trackTtl = "Let's track some";
    let parkingTtl = "parking.";
    let slashT = " / ";
    let sptFll = " Spots filled"
    
    
    func roundCorners(imgv: UIImageView){
        if (imgv == headerBacground){
            imgv.layer.cornerRadius = imgv.frame.width/15;
        }else{
            imgv.layer.cornerRadius = imgv.frame.width/30;
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //socket
        socket = manager.defaultSocket
        socketLink();
        socket.connect()

        //View setup
        outOf.layer.borderWidth = 2;
        outOf.layer.borderColor = UIColor.white.cgColor
        outOf.layer.cornerRadius = outOf.frame.width/6;
        roundCorners(imgv: headerBacground);
        roundCorners(imgv: purpCon);
        roundCorners(imgv: opaqCon)
        opaqCon.clipsToBounds = false;
        opaqCon.layer.shadowColor = UIColor.black.cgColor;
        opaqCon.layer.shadowOffset = .zero;
        opaqCon.layer.shadowOpacity = 1;
        opaqCon.layer.shadowRadius = 20;
      
        //API call to set initial values
        let apicall = DispatchGroup();
        let garageJson = "https://park-a-lot.herokuapp.com/api/v1/garages/"
        guard let url = URL(string: garageJson) else {return}
        apicall.enter();
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {print(error)}
            guard let data = data else {return}
            do{
                let garages = try JSONDecoder().decode([Garage].self, from: data)
                //self.garageList.append(garages.Garage)
                print(garages);
                let selectedGarage = garages[0]
                print("ID: ", selectedGarage._id)
                self.taken = selectedGarage.carsInLot
                self.total = selectedGarage.capacity
                self.avail = self.total - self.taken;
                
            }catch let err{
                print (err)
                
            }
            apicall.leave()
        }
        .resume()
        apicall.notify(queue: .main){
            self.ttlAvl = String(self.avail) + " Available";
            self.availableSpots.text = self.ttlAvl ;
            self.track.text = self.trackTtl;
            self.parking.text = self.parkingTtl;
            self.outOf.text = String(self.taken) + self.slashT + String(self.total);
        }
    }
    
    func socketLink(){
       socket.on(clientEvent: .connect) {data, ack in
           print("socket connected")
       }
        self.socket.on("updated") {data, ack in
            var id = data[0] as! String;
            if var carsInLot = data[1] as? String {
                self.taken = Int(carsInLot);
            }
            else {
                self.taken = data[1] as? Int;
            }
            self.track.text = self.trackTtl;
            self.parking.text = self.parkingTtl;
            self.outOf.text = String(self.taken) + self.slashT + String(self.total);
            self.avail = self.total - self.taken;
            self.ttlAvl = String(self.avail) + " Available";
            self.availableSpots.text = self.ttlAvl;
            print("ball")
            
        }
        
    }

}

