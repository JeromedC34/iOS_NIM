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
        let playButton = app.buttons["playButton"]
        let slider100 = app.sliders["100%"]
        let slider50 = app.sliders["50%"]
        let slider0 = app.sliders["0%"]
        let changeSettingsAlert = app.alerts["Change settings"]
        let switchHVHOn = app.switches["1"]
        let switchHVHOff = app.switches["0"]
        let tablesQuery = XCUIApplication().tables

        app.buttons["settingsButton"].tap()
        app.buttons["resetSettingsButton"].tap()
        app.alerts["Reset settings"].buttons["Yes"].tap()
        
        XCTAssertTrue("\(app.switches["humanVsHumanSwitch"].value!)" == "1")
        XCTAssertTrue(app.segmentedControls.buttons["20"].isSelected)
        XCTAssertTrue(app.textFields["player1NameTextField"].value as! String == "Player 1")
        XCTAssertTrue(app.textFields["player2NameTextField"].value as! String == "Player 2")
        XCTAssertTrue(app.segmentedControls.buttons["Player 1"].isSelected)
        
        app.navigationBars["Settings"].buttons["NIM game"].tap()
        app.buttons["scoresButton"].tap()
        app.navigationBars["Scores"].buttons["Reset scores"].tap()
        app.alerts["Reset scores"].buttons["Yes"].tap()
        XCTAssertFalse(tablesQuery.cells.element(boundBy: 0).exists)
        app.navigationBars["Scores"].buttons["NIM game"].tap()
        
        XCTAssertEqual(app.staticTexts["labelGameState"].label, "Player 1 - Remaining 20 matches")
        playButton.tap()
        XCTAssertEqual(app.staticTexts["labelGameState"].label, "Player 2 - Remaining 17 matches")
        playButton.tap()
        XCTAssertEqual(app.staticTexts["labelGameState"].label, "Player 1 - Remaining 14 matches")
        slider100.adjust(toNormalizedSliderPosition: 0.5)
        playButton.tap()
        XCTAssertEqual(app.staticTexts["labelGameState"].label, "Player 2 - Remaining 12 matches")
        playButton.tap()
        XCTAssertEqual(app.staticTexts["labelGameState"].label, "Player 1 - Remaining 10 matches")
        slider50.adjust(toNormalizedSliderPosition: 0)
        playButton.tap()
        XCTAssertEqual(app.staticTexts["labelGameState"].label, "Player 2 - Remaining 9 matches")
        playButton.tap()
        XCTAssertEqual(app.staticTexts["labelGameState"].label, "Player 1 - Remaining 8 matches")
        slider0.adjust(toNormalizedSliderPosition: 1)
        app.buttons["settingsButton"].tap()
        changeSettingsAlert.buttons["No"].tap()
        app.buttons["settingsButton"].tap()
        changeSettingsAlert.buttons["Yes"].tap()
        app.navigationBars["Settings"].buttons["NIM game"].tap()
        XCTAssertEqual(app.staticTexts["labelGameState"].label, "Player 1 - Remaining 8 matches")
        app.buttons["settingsButton"].tap()
        changeSettingsAlert.buttons["Yes"].tap()
        switchHVHOn.tap()
        app.navigationBars["Settings"].buttons["NIM game"].tap()
        XCTAssertEqual(app.staticTexts["labelGameState"].label, "Player 1 - Remaining 20 matches")
        app.buttons["settingsButton"].tap()
        switchHVHOff.tap()
        app.navigationBars["Settings"].buttons["NIM game"].tap()
        playButton.tap()
        playButton.tap()
        playButton.tap()
        playButton.tap()
        playButton.tap()
        playButton.tap()
        playButton.tap()
        app.alerts["Game over"].buttons["Ok"].tap()
        app.buttons["scoresButton"].tap()
        XCTAssertTrue(tablesQuery.cells.element(boundBy: 0).staticTexts["Player 2"].exists)
        XCTAssertTrue(tablesQuery.cells.element(boundBy: 0).staticTexts["Score: 10"].exists)
        XCTAssertTrue(tablesQuery.cells.element(boundBy: 1).staticTexts["Player 1"].exists)
        XCTAssertTrue(tablesQuery.cells.element(boundBy: 1).staticTexts["Score: 0"].exists)
        app.navigationBars["Scores"].buttons["NIM game"].tap()
        playButton.tap()
        playButton.tap()
        playButton.tap()
        playButton.tap()
        playButton.tap()
        playButton.tap()
        playButton.tap()
        app.alerts["Game over"].buttons["Ok"].tap()
        app.buttons["scoresButton"].tap()
        XCTAssertTrue(tablesQuery.cells.element(boundBy: 0).staticTexts["Player 2"].exists)
        XCTAssertTrue(tablesQuery.cells.element(boundBy: 0).staticTexts["Score: 20"].exists)
        XCTAssertTrue(tablesQuery.cells.element(boundBy: 1).staticTexts["Player 1"].exists)
        XCTAssertTrue(tablesQuery.cells.element(boundBy: 1).staticTexts["Score: 0"].exists)
        
        /*
         app.buttons["10"].tap()
         app.switches["0"].tap()
         app.scrollViews.otherElements.icons["iOS_NIM"].tap()
         app.images["match20"].tap()
         app.images["match2"].tap()
         app.images["match1"].tap()
         player1nametextfieldTextField.tap()
         player1nametextfieldTextField.typeText("a")
         app.textFields["player2NameTextField"].tap()
         */
    }
}
