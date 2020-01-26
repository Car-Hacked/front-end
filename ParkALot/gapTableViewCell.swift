//
//  gapTableViewCell.swift
//  ParkALot
//
//  Created by Aidan Gutierrez on 1/26/20.
//  Copyright © 2020 Spencer Jolie. All rights reserved.
//

import UIKit

class gapTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
