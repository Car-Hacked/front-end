//
//  ViewController.swift
//  ParkALot
//
//  Created by Spencer Jolie on 1/24/20.
//  Copyright © 2020 Spencer Jolie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var totalSpots: UILabel!
    @IBOutlet weak var availableSpots: UILabel!
    @IBOutlet weak var spotsTaken: UILabel!
    @IBOutlet weak var track: UILabel!
    @IBOutlet weak var parking: UILabel!
    @IBOutlet var headerBacground: UIImageView!
    @IBOutlet var purpCon: UIImageView!
    
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
        let ttlAvl = "Total Spots Available: ";
        
        //to screen
        totalSpots.text = String(total);
        availableSpots.text = String(avail);
        spotsTaken.text =   ttlAvl + String(taken);
        // Do any additional setup after loading the view.
        
        
        
        
        roundCorners(imgv: headerBacground);
        roundCorners(imgv: purpCon);
    }
    
   
    
    
    
    func roundCorners(imgv: UIImageView){
        if (imgv == headerBacground){
            imgv.layer.cornerRadius = imgv.frame.width/10;
        }else{
            imgv.layer.cornerRadius = imgv.frame.width/30;
        }
    }


}

