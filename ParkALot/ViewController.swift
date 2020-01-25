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
    
    
    func getTotalSpots(){
        total = 10;
    }
    
    func getTakenSpots(){
        taken = 2;
    }
    
    func getAvailableSpots(){
        avail = 8;
    }
    
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
        getTotalSpots();
        getAvailableSpots();
        getTakenSpots();
        
        // variables
        let ttlAvl = "Total Spots Available: " + String(avail);
        let trackTtl = "Let's track";
        let parkingTtl = "some parking.";
        let slashT = " / ";
        let sptFll = " Spots filled"
        
        //View setup
        roundCorners(imgv: headerBacground);
        roundCorners(imgv: purpCon);
        roundCorners(imgv: opaqCon)
        opaqCon.clipsToBounds = false;
        opaqCon.layer.shadowColor = UIColor.black.cgColor;
        opaqCon.layer.shadowOffset = .zero;
        opaqCon.layer.shadowOpacity = 1;
        opaqCon.layer.shadowRadius = 20;
        sideButton.layer.cornerRadius = sideButton.frame.width/15;
        sideButton.clipsToBounds = false;
        sideButton.layer.shadowColor = UIColor.black.cgColor;
        sideButton.layer.shadowOffset = .zero;
        sideButton.layer.shadowOpacity = 1;
        sideButton.layer.shadowRadius = 15;
        availableSpots.text = ttlAvl ;
        track.text = trackTtl;
        parking.text = parkingTtl;
        outOf.text = String(taken) + slashT + String(total) + sptFll;
        
        // Do any additional setup after loading the view.
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func socketLink(){
       socket.on(clientEvent: .connect) {data, ack in
           print("socket connected")
       }
        
    }

}

