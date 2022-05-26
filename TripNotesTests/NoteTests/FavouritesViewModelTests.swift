//
//  FavouritesViewModelTests.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 22.05.2022.
//

import XCTest

class FavouritesViewModelTests: XCTestCase {
    
    // MARK: Private
    
    private var viewModel: FavouritesViewModel!
    private var fireBaseServiceMock: FireBaseServiceMock!
    private var dateFormatterServiceMock: DateFormatterServiceMock!
    private var userId: String? = "123000"
    
    
    // MARK: Lifecycle

    override func setUp() {
        super.setUp()
        fireBaseServiceMock = FireBaseServiceMock()
        dateFormatterServiceMock = DateFormatterServiceMock()
        
        viewModel = .init(fireBaseService: fireBaseServiceMock,
                          dateFormatterService: dateFormatterServiceMock,
                          userId: userId!)
    }

    override func tearDown() {
        viewModel = nil
        fireBaseServiceMock = nil
        dateFormatterServiceMock = nil
        userId = nil
        super.tearDown()
    }
    
    func testNumberOfCells() throws {
        // Arrange
        let isFiltering = false
        
        // Act
        viewModel.fetchNotes()
        let numberOfCells = viewModel.numberOfCells(isFiltering: isFiltering)
        
        // Assert
        XCTAssertEqual(numberOfCells, 1)
    }
    
    func testNoteCellViewModel() {
        // Arrange
        let isFiltering = false
        let indexPath = IndexPath(item: 0, section: 0)
        
        // Act
        viewModel.fetchNotes()
        let noteCellViewModel = viewModel.noteCellViewModel(for: indexPath, isFiltering: isFiltering)
        
        // Assert
        XCTAssertEqual(noteCellViewModel?.isFavourite, true)
        XCTAssertEqual(noteCellViewModel?.city, "Paris")
        XCTAssertEqual(noteCellViewModel?.id, "1234567")
        XCTAssertEqual(noteCellViewModel?.category, "Transport")
        XCTAssertEqual(noteCellViewModel?.userId, "123000")
    }
    
    func testViewModelForSelectedRow() {
        // Arrange
        let isFiltering = false
        let indexPath = IndexPath(item: 0, section: 0)
        
        // Act
        viewModel.fetchNotes()
        let viewModelForSelectedRow = viewModel.viewModelForSelectedRow(at: indexPath, isFiltering: isFiltering)
        
        // Assert
        XCTAssertEqual(viewModelForSelectedRow.isFavourite, true)
        XCTAssertEqual(viewModelForSelectedRow.city, "Paris")
        XCTAssertEqual(viewModelForSelectedRow.id, "1234567")
        XCTAssertEqual(viewModelForSelectedRow.category, "Transport")
        XCTAssertEqual(viewModelForSelectedRow.userId, "123000")
    }
}
