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
    var name: String
    var carsInLot: Int
    var _id: String
    var capacity: Int
//    let createdAt: String
//    let updatedAt: String
//    let __v: Int
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
    @IBOutlet weak var sideButton: UIButton!
    
    let manager = SocketManager(socketURL: URL(string: "https://park-hack-api.herokuapp.com/")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    var total: Int!
    var avail: Int!
    var taken: Int!
    var ttlAvl: String!
    var garageList:[Garage] = []
    var x = 0
    let trackTtl = "Let's track";
    let parkingTtl = "some parking.";
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
        roundCorners(imgv: headerBacground);
        roundCorners(imgv: purpCon);
        roundCorners(imgv: opaqCon)
        opaqCon.clipsToBounds = false;
        opaqCon.layer.shadowColor = UIColor.black.cgColor;
        opaqCon.layer.shadowOffset = .zero;
        opaqCon.layer.shadowOpacity = 1;
        opaqCon.layer.shadowRadius = 20;
      
        //API call to set initial values
//        let apicall = DispatchGroup();
//        let garageJson = "https://park-hack-api.herokuapp.com/garages"
//        guard let url = URL(string: garageJson) else {return}
        sideButton.layer.cornerRadius = sideButton.frame.width/15;
        sideButton.clipsToBounds = false;
        sideButton.layer.shadowColor = UIColor.black.cgColor;
        sideButton.layer.shadowOffset = .zero;
        sideButton.layer.shadowOpacity = 1;
        sideButton.layer.shadowRadius = 15;
//        apicall.enter();
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {print(error)}
//            guard let data = data else {return}
//            do{
//                let garages = try JSONDecoder().decode([Garage].self, from: data)
//                //self.garageList.append(garages.Garage)
//                print(garages);
//                let selectedGarage = garages[0]
//                self.taken = selectedGarage.carsInLot
//                self.total = selectedGarage.capacity
//                self.avail = self.total - self.taken;
//                
//            }catch let err{
//                print (err)
//                
//            }
//            apicall.leave()
//        }
//        .resume()
//        apicall.notify(queue: .main){
//            self.ttlAvl = "Total Spots Available: " + String(self.avail);
//            self.availableSpots.text = self.ttlAvl ;
//            self.track.text = self.trackTtl;
//            self.parking.text = self.parkingTtl;
//            self.outOf.text = String(self.taken) + self.slashT + String(self.total) + self.sptFll;
//        }
    }
    
    func socketLink(){
       socket.on(clientEvent: .connect) {data, ack in
           print("socket connected")
       }
        self.socket.on("garageUpdate") {data, ack in
            var id = data[0] as! String;
            if var carsInLot = data[1] as? String {
                self.taken = Int(carsInLot);
            }
            else {
                self.taken = data[1] as? Int;
            }
            self.track.text = self.trackTtl;
            self.parking.text = self.parkingTtl;
            self.outOf.text = String(self.taken) + self.slashT + String(self.total) + self.sptFll;
            self.avail = self.total - self.taken;
            self.ttlAvl = "Total Spots Available: " + String(self.avail);
            self.availableSpots.text = self.ttlAvl;
            print("ball")
            
        }
        
    }

}

