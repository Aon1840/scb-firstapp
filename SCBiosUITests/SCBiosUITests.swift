//
//  SCBiosUITests.swift
//  SCBiosUITests
//
//  Created by Attapon Peungsook on 11/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import XCTest

class SCBiosUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["SQLite Database"]/*[[".cells.staticTexts[\"SQLite Database\"]",".staticTexts[\"SQLite Database\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        app.buttons["Button"].tap()
        
        var preCount = 0
        var newCount = 0
        
        // Add
        for _ in 0...10 {
            preCount = tablesQuery.cells.count
            app.buttons["Button"].tap()
            newCount = tablesQuery.cells.count
            XCTAssertTrue(newCount == (preCount + 1))
        }
        
        // obj ของ navigation bar
        let sqliteDatabaseNavigationBar = app.navigationBars["SQLite Database"]
        sqliteDatabaseNavigationBar.buttons["Edit"].tap()
        tablesQuery.children(matching: .cell).element(boundBy: 0).buttons.element(boundBy: 0).tap()
        
        // Remove
        for _ in 0...10 {
            preCount = tablesQuery.cells.count
            tablesQuery.buttons["Delete"].tap()
            newCount = tablesQuery.cells.count
            XCTAssertTrue((newCount+1) == (preCount))
        }
        
        sqliteDatabaseNavigationBar.buttons["Done"].tap()
    }

}
