//
//  SCBFeed.swift
//  SCBios
//
//  Created by Attapon Peungsook on 11/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import Alamofire

class SCBFeed {
    // completion คือการทำ call back กลับไปเป็น Youtube array
    func feed(url:String, params:[String:String], completion:@escaping ([Youtube])->()){
        AF.request(URL(string: url)!, method: .post, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                //                print(value)
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(YoutubeResponse.self, from: response.data!)
                    completion(result.youtubes)
                    print("------ \(result.youtubes[0])")
                    break
                }catch{
                    
                }
            case .failure(let error):
                break
            }
        }
    }
}
