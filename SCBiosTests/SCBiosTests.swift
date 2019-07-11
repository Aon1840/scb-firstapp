//
//  SCBiosTests.swift
//  SCBiosTests
//
//  Created by Attapon Peungsook on 11/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import XCTest
@testable import SCBios

class SCBiosTests: XCTestCase {

    var mFeed:SCBFeed!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.mFeed = SCBFeed()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNormalFeed(){
        let _url = "http://codemobiles.com/adhoc/youtubes/index_new.php?username=admin&password=password&type=foods"
        let _params = ["username": "admin", "password": "password", "type": "foods"]
        let expection = self.expectation(description: "fetch posts")
        
        self.mFeed.feed(url: _url, params: _params) { (result) in
//            XCTAssertTrue(result.count == 11)
//            expection.fulfill()
            XCTAssertTrue(result[0].title == "Laura in the Kitchen")
            expection.fulfill()
        }
        
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testNormalSong(){
        
    }

   

}
