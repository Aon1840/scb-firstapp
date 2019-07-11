//
//  PageThreeViewController.swift
//  SCBios
//
//  Created by Attapon Peungsook on 8/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit
import XCDYouTubeKit

class PageThreeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var mDataArray: [Youtube] = []
    @IBOutlet var mTableView: UITableView!
    var mBlurView: DKLiveBlurView!
    var mRefreshControl: UIRefreshControl!
    var mFeed: SCBFeed!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mFeed = SCBFeed()
        feedData()

        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 350)
        mTableView.tableHeaderView = headerView

        mBlurView = DKLiveBlurView()
        // load รูปภาพแบบไม่เบลอก่อน
        mBlurView.originalImage = UIImage(named: "listview_iphone.png")
        mTableView.backgroundView = mBlurView

        // มอบ delegate ของ mTableView ให้ mBlurView เพื่อให้รู้ตำแหน่งที่เป็นความสามารถของ TableView
        mBlurView.scrollView = mTableView

        // initail ค่าของ pullToRefresh
        // add target เอาไว้ผูก event -> ให้ใส่ obj ที่บรรจุของฟังก์ชัน
        mRefreshControl = UIRefreshControl()
        mRefreshControl.addTarget(self, action: #selector(feedData), for: .valueChanged)
        mTableView.addSubview(mRefreshControl)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scbcell") as? TableViewCell
        let item = mDataArray[indexPath.row]

        cell?.mTitle.text = item.title
        cell?.mSubtitle.text = item.subtitle
        let tumbnail = item.youtubeImage

        let avatar = item.avatarImage
        cell?.mAvatar.loadImageUrl(item.avatarImage)
        cell?.mYoutube.loadImageUrl(item.youtubeImage)

//        cell?.mYoutube.af_setImage(withURL: URL(string: tumbnail)!)
//        cell?.mAvatar.af_setImage(withURL: URL(string: avatar)!)

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("----- Selected row: \(indexPath.row)")
        mTableView.deselectRow(at: indexPath, animated: true)

        let item = mDataArray[indexPath.row]
        let vc = XCDYouTubeVideoPlayerViewController(videoIdentifier: item.id)
        present(vc, animated: true, completion: nil)
    }

    @objc
    func feedData() {
        self.mDataArray.removeAll()
        let _url = "http://codemobiles.com/adhoc/youtubes/index_new.php?username=admin&password=password&type=foods"
        let _params = ["username": "admin", "password": "password", "type": "foods"]
        self.mFeed.feed(url: _url, params: _params) { (result) in
            self.mDataArray += result
            self.mTableView.reloadData()
            self.mRefreshControl.endRefreshing()
        }
        
    }

//        ย้ายไปอยู้ SCBFeed.swift
//        let url = "http://codemobiles.com/adhoc/youtubes/index_new.php?username=admin&password=password&type=foods"
//        let data = ["username":"admin", "password":"password", "type":"foods"]
//        AF.request(URL(string: url)!, method: .post, parameters: data).responseJSON { (response) in
//            switch response.result {
//            case .success(let value):
        ////                print(value)
//                do{
//                    let decoder = JSONDecoder()
//                    let result = try decoder.decode(YoutubeResponse.self, from: response.data!)
//                    self.mDataArray += result.youtubes
//                    self.mTableView.reloadData()
//                    self.mRefreshControl.endRefreshing()
//                    print("------ \(result.youtubes[0])")
//                    break
//                }catch{
//
//                }
//            case .failure(let error):
//                break
//            }
//        }
//    }

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
