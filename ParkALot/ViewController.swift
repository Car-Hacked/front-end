//
//  ViewController.swift
//  ParkALot
//
//  Created by Spencer Jolie on 1/24/20.
//  Copyright © 2020 Spencer Jolie. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {
    
    //outlet
    @IBOutlet weak var availableSpots: UILabel!
    @IBOutlet weak var track: UILabel!
    @IBOutlet weak var parking: UILabel!
    @IBOutlet var headerBacground: UIImageView!
    @IBOutlet var purpCon: UIImageView!
    @IBOutlet weak var outOf: UILabel!
    @IBOutlet weak var opaqCon: UIImageView!
    @IBOutlet weak var goTo: UIButton!
    @IBOutlet weak var garageName: UILabel!
    
    //vars
    var socket: SocketIOClient!
    var total: Int!
    var avail: Int!
    var taken: Int!
    var ttlAvl: String?
    var garageList:[Garage] = []
    let manager = SocketManager(socketURL: URL(string: "https://park-a-lot.herokuapp.com/")!, config: [.log(true), .compress])
    var currGar: Garage?
    
    //outlet functions
    @IBAction func backTo(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //takes user to a map with directions to parking garage
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
    
    
    func roundCorners(imgv: UIImageView){
        if (imgv == headerBacground){
            imgv.layer.cornerRadius = imgv.frame.width/15;
        }else{
            imgv.layer.cornerRadius = imgv.frame.width/30;
        }
    }
    
    func setup(curg: Garage){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //socket connection
        socket = manager.defaultSocket
        socketLink();
        socket.connect()

        //View setup
        self.total = currGar?.capacity;
        self.taken = currGar?.carsInLot;
        self.avail = self.total - self.taken;
        self.outOf.text = (String(self.taken) + " / " + String(self.total));
        self.ttlAvl = String(avail) + "Available";
        self.availableSpots.text = self.ttlAvl
        self.garageName.text = currGar?.garageName

        outOf.layer.borderWidth = 2;
        outOf.layer.borderColor = UIColor.white.cgColor
        outOf.layer.cornerRadius = outOf.frame.width/6;
        goTo.layer.cornerRadius = goTo.frame.width/60;
        goTo.layer.shadowOffset = CGSize(width:0,height: 16);
        goTo.layer.shadowOpacity = 0.5;
        goTo.layer.shadowRadius = 20;

        roundCorners(imgv: headerBacground);
        roundCorners(imgv: purpCon);
        roundCorners(imgv: opaqCon)
        opaqCon.clipsToBounds = false;
        opaqCon.layer.shadowColor = UIColor.black.cgColor;
        opaqCon.layer.shadowOffset = .zero;
        opaqCon.layer.shadowOpacity = 1;
        opaqCon.layer.shadowRadius = 20;
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
            
            self.outOf.text = String(self.taken) + " / " + String(self.total);
            self.avail = self.total - self.taken;
            self.ttlAvl = String(self.avail) + " Available";
            self.availableSpots.text = self.ttlAvl;
            print("ball")
            
        }

    }

}

