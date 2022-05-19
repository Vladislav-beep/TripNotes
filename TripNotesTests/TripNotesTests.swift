//
//  TripNotesTests.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 14.12.2021.
//

import XCTest
@testable import TripNotes

class TripNotesTests: XCTestCase {
    
    var viewModel: TabBarViewModel!
    var authServiceMock: AuthServiceMock!

    override func setUp() {
        authServiceMock = AuthServiceMock()
        viewModel = .init(authService: authServiceMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {

        let exp = XCTestExpectation()
        var userID: String?
        let completion = { userID in userID = "123" }
     //   viewModel.completion = completion
        
        viewModel.fetchUserId()
        exp.fulfill()
        
  //      viewModel.completion = completion
//        viewModel.completion = { id in
//            userID = id
//        }
        
       // viewModel.completion = completion
    //    XCTAssertNotNil(viewModel.fetchUserId())
        XCTAssertEqual(userID, "123")
    }



}
