//
//  SCB+Additional.swift
//  SCBios
//
//  Created by Attapon Peungsook on 9/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    func loadImageUrl(_ urlString:String){
        self.af_setImage(withURL: URL(string: urlString)!)
    }
        
}

extension UIView {
    func makeCircle(_ radius:CGFloat? = nil){
        if let r = radius {
            self.layer.cornerRadius = r
        } else {
            self.layer.cornerRadius = self.frame.width / 2
        }
    }
}
