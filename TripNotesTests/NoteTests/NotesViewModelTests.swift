//
//  NotesViewModelTests.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 21.05.2022.
//

import XCTest

class NotesViewModelTests: XCTestCase {
    
    // MARK: Private
    
    private var viewModel: NotesViewModel!
    private var fireBaseServiceMock: FireBaseServiceMock!
    private var dateFormatterServiceMock: DateFormatterServiceMock!
    private var trip: Trip? = TripStub().getTripsStub().first!
    private var userId: String? = "123"
    
    
    // MARK: Lifecycle

    override func setUp() {
        super.setUp()
        fireBaseServiceMock = FireBaseServiceMock()
        dateFormatterServiceMock = DateFormatterServiceMock()
        
        viewModel = .init(trip: trip,
                          fireBaseService: fireBaseServiceMock,
                          dateFormatterService: dateFormatterServiceMock,
                          userId: userId!)
    }

    override func tearDown() {
        viewModel = nil
        fireBaseServiceMock = nil
        dateFormatterServiceMock = nil
        trip = nil
        userId = nil
        super.tearDown()
    }
    
    
    // MARK: TESTS

    func testnumberOfCells() {
        // Arrange
        let expectedNumberOfCells = 2
        
        // Act
        viewModel.fetchNotes()
        let numberOfCells = viewModel.numberOfCells()
        
        // Assert
        XCTAssertEqual(numberOfCells, expectedNumberOfCells)
    }
    
    func testNoteCellViewModel() {
        // Arrange
        let indexPath = IndexPath(row: 0, section: 0)
        
        // Act
        viewModel.fetchNotes()
        let noteCellViewModel = viewModel.noteCellViewModel(for: indexPath)
        
        // Assert
        XCTAssertEqual(noteCellViewModel?.userId, "123")
        XCTAssertEqual(noteCellViewModel?.id, "1234567")
        XCTAssertEqual(noteCellViewModel?.description, "Bus ride")
        XCTAssertEqual(noteCellViewModel?.category, "Transport")
        XCTAssertEqual(noteCellViewModel?.city, "Paris")
        XCTAssertEqual(noteCellViewModel?.isFavourite, true)
    }
    
    func testViewModelForSelectedRow() {
        // Arrange
        let indexPath = IndexPath(row: 0, section: 0)
        
        // Act
        viewModel.fetchNotes()
        let viewModelForSelectedRow = viewModel.viewModelForSelectedRow(at: indexPath)
        
        // Assert
        XCTAssertEqual(viewModelForSelectedRow.userId, "123")
        XCTAssertEqual(viewModelForSelectedRow.id, "1234567")
        XCTAssertEqual(viewModelForSelectedRow.description, "Bus ride")
        XCTAssertEqual(viewModelForSelectedRow.category, "Transport")
        XCTAssertEqual(viewModelForSelectedRow.city, "Paris")
        XCTAssertEqual(viewModelForSelectedRow.isFavourite, true)
    }
}
