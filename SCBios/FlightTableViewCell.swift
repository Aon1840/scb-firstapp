//
//  FlightTableViewCell.swift
//  SCBios
//
//  Created by Attapon Peungsook on 10/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {

    @IBOutlet weak var mLabel:UILabel!
    @IBOutlet weak var mIcon:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
