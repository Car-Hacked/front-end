//
//  garageTableViewCell.swift
//  ParkALot
//
//  Created by Aidan Gutierrez on 1/26/20.
//  Copyright © 2020 Spencer Jolie. All rights reserved.
//

import UIKit

class garageTableViewCell: UITableViewCell {
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellLocation: UILabel!
    @IBOutlet weak var dotOfTruth: UIImageView!
    @IBOutlet weak var avail: UILabel!
    
    var garry: Garage!
    func setup (garage: Garage){
        cellName.text = garage.garageName;
        cellLocation.text = "Nashville, TN";
        garry = garage
        let cap = Float(garry.capacity)
        let cin = Float(garry.carsInLot)
        self.avail.text = String(Int(cap-cin))
        if (cin/cap) < 0.75{
            dotOfTruth.backgroundColor = UIColor(red:0.27, green:1.00, blue:0.70, alpha:1.0)
        }
        if(cin/cap) > 0.99{dotOfTruth.backgroundColor = UIColor(red:1.00, green:0.05, blue:0.24, alpha:1.0)}
        else {
            dotOfTruth.backgroundColor = UIColor(red:0.06, green:0.99, blue:0.71, alpha:1.0)
        }
        
 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = self.frame.width / 55
        self.clipsToBounds = true;
        self.layer.shadowColor = UIColor.black.cgColor;
        self.layer.shadowOffset = .zero;
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 5;
        dotOfTruth.layer.cornerRadius = dotOfTruth.frame.width/2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    
    }

}
