//
//  TripNotesUITestsLaunchTests.swift
//  TripNotesUITests
//
//  Created by Владислав Сизонов on 08.06.2022.
//

import XCTest

class TripNotesUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testCreateNewAccountNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Create new account"].tap()
        XCTAssertTrue(app.staticTexts["Create new account"].exists)
    }
}
