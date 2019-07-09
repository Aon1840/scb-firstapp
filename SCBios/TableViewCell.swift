//
//  TableViewCell.swift
//  SCBios
//
//  Created by Attapon Peungsook on 9/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var mTitle:UILabel!
    @IBOutlet weak var mSubtitle:UILabel!
    @IBOutlet weak var mAvatar:UIImageView!
    @IBOutlet weak var mYoutube:UIImageView!
    @IBOutlet weak var mCardView:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        self.mAvatar.layer.cornerRadius = self.mAvatar.frame.width / 2
        self.mAvatar.makeCircle()
        self.mAvatar.makeCircle(10.0)
        self.mCardView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        self.mCardView.makeCircle(10.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
