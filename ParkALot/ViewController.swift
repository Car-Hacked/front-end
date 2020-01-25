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
    let garageNumber: Int
    let carsInLot: Int
    let _id: String
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
    @IBOutlet weak var sideButton: UIButton!
    let manager = SocketManager(socketURL: URL(string: "https://park-a-lot.herokuapp.com/")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    var total: Int!
    var avail: Int!
    var taken: Int!
    var garageList:[Garage] = []
    
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
        //Meathods
        parseJson(x: 0)
        
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
        let apicall = DispatchGroup();
        let garageJson = "https://park-a-lot.herokuapp.com/api/v1/garages"
        guard let url = URL(string: garageJson) else {return}
        sideButton.layer.cornerRadius = sideButton.frame.width/15;
        sideButton.clipsToBounds = false;
        sideButton.layer.shadowColor = UIColor.black.cgColor;
        sideButton.layer.shadowOffset = .zero;
        sideButton.layer.shadowOpacity = 1;
        sideButton.layer.shadowRadius = 15;
        apicall.enter();
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {print(error)}
            guard let data = data else {return}
            do{
                let garages = try JSONDecoder().decode([Garage].self, from: data)
                //self.garageList.append(garages.Garage)
                print(garages);
                let selectedGarage = garages[0]
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
            let ttlAvl = "Total Spots Available: " + String(self.avail);
            let trackTtl = "Let's track";
            let parkingTtl = "some parking.";
            let slashT = " / ";
            let sptFll = " Spots filled"
            self.availableSpots.text = ttlAvl ;
            self.track.text = trackTtl;
            self.parking.text = parkingTtl;
            self.outOf.text = String(self.taken) + slashT + String(self.total) + sptFll;
        }
    }
    
    func parseJson(x: Int) {
        
        
      }
     
    func socketLink(){
       socket.on(clientEvent: .connect) {data, ack in
           print("socket connected")
       }
        
    }

}

