//
//  NewNoteViewModelTests.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 22.05.2022.
//

import XCTest

class NewNoteViewModelTests: XCTestCase {

    // MARK: Private
    
    private var viewModel: NewNoteViewModel!
    private var fireBaseServiceMock: FireBaseServiceMock!
    private var userId: String? = "XXXX"
    private var tripId: String? = "00000"
    private var noteId: String? = "12345"
    
    
    // MARK: Lifecycle

    override func setUp() {
        super.setUp()
        fireBaseServiceMock = FireBaseServiceMock()
        
        viewModel = .init(userId: userId!,
                          tripId: tripId!,
                          noteId: noteId!,
                          fireBaseService: fireBaseServiceMock)
    }

    override func tearDown() {
        viewModel = nil
        fireBaseServiceMock = nil
        userId = nil
        tripId = nil
        noteId = nil
        super.tearDown()
    }
    
    
    // MARK: TESTS

    func testDownloadNote() {
        // Act
        viewModel.downloadNote()
        
        // Assert
        XCTAssertEqual(viewModel.city, "Moscow")
        XCTAssertEqual(viewModel.category, "Food")
        XCTAssertEqual(viewModel.description, "Went to cafe")
        XCTAssertEqual(viewModel.address, "Puschin street")
        XCTAssertEqual(viewModel.price, "78.35")
    }
}