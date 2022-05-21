//
//  TripsTests.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 19.05.2022.
//

import XCTest
@testable import TripNotes

class TripsViewModelTests: XCTestCase {
    
    // MARK: Private
    
    private var viewModel: TripsViewModel!
    private var authServiceMock: AuthServiceMock!
    private var fireBaseServiceMock: FireBaseServiceMock!
    private var fileStorageServiceMock: FileStorageServiceMock!
    private var dateFormatterServiceMock: DateFormatterServiceMock!
    
    
    // MARK: Lifecycle
    
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
    
    
    // MARK: TESTS
    
    func testTitleForHeaderInFirstSection() {
        // Arrange
        let expectedTitle = I.sectionPastTitle
        let section = 1
        
        // Act
        let title = viewModel.titleForHeaderInSection(section: section)
        
        // Assert
        XCTAssertEqual(title, expectedTitle)
    }
    
    func testTitleForHeaderInZeroSection() {
        // Arrange
        let expectedTitle = I.sectionPlannedTitle
        let section = 0
        
        // Act
        let title = viewModel.titleForHeaderInSection(section: section)
        
        // Assert
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
    
    func testViewModelForSelectedRow() {
        // Arrange
        let indexPath = IndexPath(row: 0, section: 0)
        let section = indexPath.section
        
        // Act
        viewModel.fetchTrips()
        let _ = viewModel.numberOfRows(section: section)
        let viewModel = viewModel.viewModelForSelectedRow(at: indexPath)
        
        // Assert
        XCTAssertEqual(viewModel.text, "Russia")
        XCTAssertEqual(viewModel.totalSum, "0 ₽")
    }
    
    func testNewTripViewModelEdited() {
        // Arrange
        let indexPath = IndexPath(row: 0, section: 0)
        let section = indexPath.section
        
        // Act
        viewModel.fetchTrips()
        let _ = viewModel.numberOfRows(section: section)
        let newTripViewModelEdited = viewModel.newTripViewModelEdited(for: indexPath)
        
        // Assert
        XCTAssertEqual(newTripViewModelEdited.tripId, "123")
    }
    
    func testNewTripViewModel() {
        // Arrange
        let indexPath = IndexPath(row: 0, section: 0)
        let section = indexPath.section
        
        // Act
        viewModel.fetchTrips()
        let _ = viewModel.numberOfRows(section: section)
        let newTripViewModel = viewModel.newTripViewModel()
        
        // Assert
        XCTAssertEqual(newTripViewModel.tripId, "")
    }
    
    func testNewNoteViewModel() {
        // Arrange
        let indexPath = IndexPath(row: 0, section: 0)
        let section = indexPath.section
        
        // Act
        viewModel.fetchTrips()
        let _ = viewModel.numberOfRows(section: section)
        let newNoteViewModel = viewModel.newNoteViewModel(at: indexPath)
        
        // Assert
        XCTAssertEqual(newNoteViewModel.tripId, "123")
    }
    
    func testDeleteRow() {
        // Arrange
        let indexPath = IndexPath(row: 0, section: 0)
        let section = indexPath.section
        let errorCompletion: () -> Void = { }
        
        // Act
        viewModel.fetchTrips()
        let _ = viewModel.numberOfRows(section: section)
        viewModel.deleteRow(at: indexPath, errorCompletion: errorCompletion)
        
        // Assert
        XCTAssertEqual(viewModel.trips.count, 1)
    }
    
    func testGetTripId() {
        // Arrange
        let indexPath = IndexPath(row: 0, section: 1)
        let section = indexPath.section
        
        // Act
        viewModel.fetchTrips()
        let _ = viewModel.numberOfRows(section: section)
        let tripId = viewModel.getTripId(for: indexPath)
        
        // Assert
        XCTAssertEqual(tripId, "456")
    }
}
