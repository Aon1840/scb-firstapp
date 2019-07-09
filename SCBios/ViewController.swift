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
        // Call automically after view initial ถูกเรียกอัตโนมัติ ดักจับ event
        self.title = "CodeMobiles"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  Define destination page by using segue
        let targetVC = segue.destination
        print("---- target: \(targetVC)")
        
        // Select index from
        let selectedIndex = self.tableView.indexPathForSelectedRow
        print("---- selectedIndex: \(selectedIndex)")
        
        let selectedCell = self.tableView.cellForRow(at: selectedIndex!)
        print("---- selectedCell: \(selectedCell)")
        
        // ? that tell you selectedCell have or not have
        targetVC.title = selectedCell?.textLabel?.text
    }
    
    


}

