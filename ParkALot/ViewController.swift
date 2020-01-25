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
        getTotalSpots();
        getAvailableSpots();
        getTakenSpots();
        totalSpots.text = String(total);
        availableSpots.text = String(avail);
        spotsTaken.text = String(taken);
        // Do any additional setup after loading the view.
    }


}

