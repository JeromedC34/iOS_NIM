//
//  iOS_NIMUITests.swift
//  iOS_NIMUITests
//
//  Created by imac on 10/11/2016.
//  Copyright © 2016 imac. All rights reserved.
//

import XCTest

class iOS_NIMUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let playButton = app.buttons["Play"]
        
        playButton.tap()
        XCTAssertTrue(app.staticTexts["labelGameState"].label == "Player 2 - Remaining 17 matches" || app.staticTexts["labelGameState"].label == "Player 1 - Remaining 17 matches")
        
        /*
         let switch2 = app.switches["1"]
         let changePlayer2Alert = app.alerts["Change player 2"]
         let slider100 = app.sliders["100%"]
         let slider50 = app.sliders["50%"]
         let slider0 = app.sliders["0%"]
         
         switch2.tap()
         slider100.swipeLeft()
         slider50.swipeRight()
         slider0.swipeRight()
         
         playButton.tap()
         
         changePlayer2Alert.buttons["No"].tap()
         changePlayer2Alert.buttons["Yes"].tap()
         
         app.staticTexts["Player 1 - Remaining 20 matches"].tap()
         
         app.images["match19"].tap()
         app.images["match20"].tap()
         app.images["match13"].tap()
         */
        
    }
    
}
