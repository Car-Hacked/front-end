//
//  ViewController.swift
//  ParkALot
//
//  Created by Spencer Jolie on 1/24/20.
//  Copyright © 2020 Spencer Jolie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var availableSpots: UILabel!
    @IBOutlet weak var track: UILabel!
    @IBOutlet weak var parking: UILabel!
    @IBOutlet weak var garageName: UILabel!
    @IBOutlet weak var outOf: UILabel!
    
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup
        getTotalSpots();
        getAvailableSpots();
        getTakenSpots();
        
        // variables
        let ttlAvl = "Total Spots Available: " + String(avail);
        let trackTtl = "Let's track";
        let parkingTtl = "some parking.";
        let slashT = "/";
        let sptFll = "Spots filled"
        
        //to screen
        availableSpots.text = ttlAvl ;
        track.text = trackTtl;
        parking.text = parkingTtl;
        outOf.text = String(taken) + slashT + String(total) + sptFll;
        // Do any additional setup after loading the view.
    }


}

