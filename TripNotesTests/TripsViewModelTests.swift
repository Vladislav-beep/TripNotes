//
//  TripsTests.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 19.05.2022.
//

import XCTest
@testable import TripNotes

class TripsViewModelTests: XCTestCase {
    
    var viewModel: TripsViewModel!
    var authServiceMock: AuthServiceMock!
    var fireBaseServiceMock: FireBaseServiceMock!
    var fileStorageServiceMock: FileStorageServiceMock!
    var dateFormatterServiceMock: DateFormatterServiceMock!
    
    
    override func setUp() {
        super.setUp()
        authServiceMock = AuthServiceMock()
        fireBaseServiceMock = FireBaseServiceMock()
        fileStorageServiceMock = FileStorageServiceMock()
        dateFormatterServiceMock = DateFormatterServiceMock()
        
        viewModel = .init(fireBaseService: fireBaseServiceMock,
                          userId: "",
                          fileStorageService: fileStorageServiceMock,
                          dateFormatterService: dateFormatterServiceMock,
                          authService: authServiceMock)
        
    }
    
    override func tearDown (){
        viewModel = nil
        authServiceMock = nil
        fireBaseServiceMock = nil
        fileStorageServiceMock = nil
        dateFormatterServiceMock = nil
        super.tearDown()
    }
    
    func testTitleForHeaderInFirstSection() {
        // Arrange
        let expectedTitle = I.sectionPastTitle
        let section = 1
        
        // Act
        let title = viewModel.titleForHeaderInSection(section: section)
        
        // assert
        XCTAssertEqual(title, expectedTitle)
    }
    
    func testTitleForHeaderInZeroSection() {
        // Arrange
        let expectedTitle = I.sectionPlannedTitle
        let section = 0
        
        // Act
        let title = viewModel.titleForHeaderInSection(section: section)
        
        // assert
        XCTAssertEqual(title, expectedTitle)
    }
    
    func testNumberOfRowsInZeroSection() {
        // Arrange
        let section = 0
        let expectedNumberOfRows = 1
        
        // Act
        viewModel.fetchTrips()
        let numberOfRows = viewModel.numberOfRows(section: section)
        
        // Assert
        XCTAssertEqual(numberOfRows, expectedNumberOfRows)
    }
    
    func testNumberOfRowsInFirstSection() {
        // Arrange
        let section = 1
        let expectedNumberOfRows = 1
        
        // Act
        viewModel.fetchTrips()
        let numberOfRows = viewModel.numberOfRows(section: section)
        
        // Assert
        XCTAssertEqual(numberOfRows, expectedNumberOfRows)
    }
    
    func testTripCellViewModel() {
        // Arrange
        let indexPath = IndexPath(row: 0, section: 0)
        let section = indexPath.section
        
        // Act
        viewModel.fetchTrips()
        let _ = viewModel.numberOfRows(section: section)
        let tripCellViewModel = viewModel.tripCellViewModel(for: indexPath)
        
        // Assert
        XCTAssertEqual(tripCellViewModel?.country, "RUSSIA")
        XCTAssertEqual(tripCellViewModel?.currency, "₽")
        XCTAssertEqual(tripCellViewModel?.description, "Trip to Russia")
    }
}

