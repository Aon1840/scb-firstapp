//
//  ViewController.swift
//  SCBios
//
//  Created by Attapon Peungsook on 8/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Call automically after view inital ถูกเรียกอัตโนมัติ ดักจับ event
        // Do any additional setup after loading the view.
        self.title = "CodeMobiles"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let targetVC = segue.destination
        let selectedIndex = self.tableView.indexPathForSelectedRow
        let selectedCell = self.tableView.cellForRow(at: selectedIndex!)
        targetVC.title = selectedCell?.textLabel?.text
    }
    
    


}

