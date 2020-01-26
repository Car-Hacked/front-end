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
    var garry: Garage!
    
    func setup (garage: Garage){
        cellName.text = garage.garageName;
        cellLocation.text = garage.address;
        garry = garage
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = self.frame.width / 55
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("HERE")
        let carryGarry = garry

       

        //        let singleDisplay = ViewController()
        //        singleDisplay.Name = carryName
        //        RVC.Image = carryImage
        //        RVC.Description = carryDescription
        //        self.present(RVC, animated: true, completion: nil)
  
    }
    

}
