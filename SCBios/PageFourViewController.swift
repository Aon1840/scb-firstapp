//
//  PageFourViewController.swift
//  SCBios
//
//  Created by Attapon Peungsook on 8/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import FMDB

class PageFourViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //    UITableViewDelegate -> provide เกี่ยวกับ interact ต่างๆ
    //    UITableViewDataSource -> เกี่ยวกับจัดการข้อมูล
    
    @IBOutlet weak var mTableView:UITableView!
    var mDatabase:FMDatabase!
    var mDataArray:[[String:Any]] = []
    let mFlightDummyArray:[String] =
        ["07:00     TG102       BKK     A33",
         "16:30     BE731       LON     B01",
         "09:45     FR122       FRA     D23",
         "19:30     AA911       AME     F53",
         "01:20     CN099       CHA     G22",
         "12:10     TG233       DEN     A23",
         "17:40     KR122       LDN     J32",
         "13:30     JP291       JAN     C04",
         "20:20     KR001       KOR     D09",
         "21:10     LU022       SPN     E22",
         "22:40     TG110       URN     A18"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // enable edit button
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.openDB()
        self.query()
    }
    
    func query(){
        self.mDataArray.removeAll()
        if let rs = self.mDatabase.executeQuery("SELECT ROW, FIELD_DATA FROM FIELDS ORDER BY ROW DESC", withArgumentsIn: []){
            while rs.next() {
                let colID = rs.int(forColumn: "ROW")
                let colData = rs.string(forColumn: "FIELD_DATA")
                
                let item:[String:Any] = ["id":colID, "data": colData]
                self.mDataArray.append(item)
                self.mTableView.reloadData()
            }
        }
    }
    
    func openDB(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/data.sqlite"
        print("----- path: \(path)")
        let fileMgr = FileManager()
        
        do {
            if (!fileMgr.fileExists(atPath: path)) {
                // no database file - copy is required
                let orgPath = Bundle.main.path(forResource: "data.sqlite", ofType: nil)
                try fileMgr.copyItem(atPath: orgPath!, toPath: path)
            }
            
            // open db
            self.mDatabase = FMDatabase(path: path)
            self.mDatabase.open()
            
            
        } catch {
            
        }
    }
    
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        if self.editButtonItem.title == "Edit" {
            self.editButtonItem.title = "Done"
            self.mTableView.setEditing(true, animated: true)
            
        } else {
            self.editButtonItem.title = "Edit"
            self.mTableView.setEditing(false, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flightcell") as? FlightTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell?.mIcon.image = UIImage(named: "landing_icon.png")
        } else {
            cell?.mIcon.image = UIImage(named: "takeoff_icon.png")
        }
        
        let item = self.mDataArray[indexPath.row]
        cell?.mLabel.text = item["data"] as? String
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = tableView.dequeueReusableCell(withIdentifier: "section")
        
        return section!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    @IBAction func addFlight() {
        print("Add Flight")
        let randomIndex = Int(arc4random_uniform(11))
        let dummyData = self.mFlightDummyArray[randomIndex]
        self.mDatabase.executeUpdate("INSERT INTO FIELDS (FIELD_DATA) VALUES (?)", withArgumentsIn: [dummyData])
        self.query()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = self.mDataArray[indexPath.row]
            let colID = item["id"]
            self.mDatabase.executeUpdate("DELETE FROM FIELDS WHERE ROW = ?", withArgumentsIn: [colID!])
            self.query()
        }
    }
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
