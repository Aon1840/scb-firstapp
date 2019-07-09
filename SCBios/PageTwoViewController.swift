//
//  PageTwoViewController.swift
//  SCBios
//
//  Created by Attapon Peungsook on 8/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import QRCode

class PageTwoViewController: UIViewController {

    @IBOutlet weak var mTextField:UITextField!
    @IBOutlet weak var mQRCodeImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mTextField.text = "Aon"
    }
    

    @IBAction func onTextChange(sender: AnyObject) {
        print(sender.text!)
        let textFeild = sender as! UITextField
//        let text = textFeild.text
        
//        ถ้า text มีค่าจะเข้า if
        if let text = textFeild.text {
            var qrCode = QRCode(text != "" ? text : "Aon")
            qrCode?.backgroundColor = CIColor(rgba: "FF00FF")
            self.mQRCodeImageView.image = qrCode?.image
        }
    }
}
