//
//  PageThreeViewController.swift
//  SCBios
//
//  Created by Attapon Peungsook on 8/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class PageThreeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var mDataArray:[Youtube] = []
    @IBOutlet weak var mTableView:UITableView!
    var mBlurView:DKLiveBlurView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scbcell") as? TableViewCell
        let item = self.mDataArray[indexPath.row]
        
        cell?.mTitle.text = item.title
        cell?.mSubtitle.text = item.subtitle
        let tumbnail =  item.youtubeImage
        
        let avatar = item.avatarImage
        cell?.mAvatar.loadImageUrl(item.avatarImage)
        cell?.mYoutube.loadImageUrl(item.youtubeImage)
        
//        cell?.mYoutube.af_setImage(withURL: URL(string: tumbnail)!)
//        cell?.mAvatar.af_setImage(withURL: URL(string: avatar)!)
        
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedData()
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 350)
        self.mTableView.tableHeaderView = headerView
        
        self.mBlurView = DKLiveBlurView()
//        load รูปภาพแบบไม่เบลอก่อน
        self.mBlurView.originalImage = UIImage(named: "listview_iphone.png")
        self.mTableView.backgroundView = self.mBlurView
        
//        มอบ delegate ของ mTableView ให้ mBlurView เพื่อให้รู้ตำแหน่งที่เป็นความสามารถของ TableView
        self.mBlurView.scrollView = self.mTableView
        // Do any additional setup after loading the view.
    }
    
    func feedData(){
        let url = "http://codemobiles.com/adhoc/youtubes/index_new.php?username=admin&password=password&type=foods"
        let data = ["username":"admin", "password":"password", "type":"foods"]
        AF.request(URL(string: url)!, method: .post, parameters: data).responseJSON { (response) in
            switch response.result {
            case .success(let value):
//                print(value)
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(YoutubeResponse.self, from: response.data!)
                    self.mDataArray += result.youtubes
                    self.mTableView.reloadData()
                    print("------ \(result.youtubes[0])")
                    break
                }catch{
                    
                }
            case .failure(let error):
                break
            }
        }
    }
//    func feedData(){
//        let url = "http://codemobiles.com/adhoc/youtubes/index_new.php?username=admin&password=password&type=foods"
//        AF.request(URL(string: url)!).responseString{ (response) in
//            switch response.result {
//            case .success:
//                print(response.result)
//                break
//            case .failure:
//                break
//            default:
//                break
//            }
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
