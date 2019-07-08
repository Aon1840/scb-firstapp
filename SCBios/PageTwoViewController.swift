//
//  PageTwoViewController.swift
//  SCBios
//
//  Created by Attapon Peungsook on 8/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class PageTwoViewController: UIViewController {

    @IBOutlet weak var mTextField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mTextField.text = "Aon"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onTextChange(sender: AnyObject) {
        print(sender.text!)
    }
}
