//
//  TripsTests.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 19.05.2022.
//

import XCTest
@testable import TripNotes

class TripsTests: XCTestCase {
    
    var viewModel: TripsViewModel!
    var authServiceMock: AuthServiceMock!
    var fireBaseServiceMock: FireBaseServiceMock!
    var FileStorageServiceMock: FileStorageServiceMock!
    var DateFormatterServiceMock: DateFormatterServiceMock!


    override func setUp() {
        viewModel = .init(fireBaseService: fireBaseServiceMock,
                          userId: "",
                          fileStorageService: FileStorageServiceMock,
                          dateFormatterService: DateFormatterServiceMock,
                          authService: authServiceMock)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {

    }



}

