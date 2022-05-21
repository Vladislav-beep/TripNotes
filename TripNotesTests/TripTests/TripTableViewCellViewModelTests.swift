//
//  TripTableViewCellViewModelTests.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 21.05.2022.
//

import XCTest
@testable import TripNotes

class TripTableViewCellViewModelTests: XCTestCase {
    
    // MARK: Private
    
    private var viewModel: TripTableViewCellViewModel!
    private var fileStorageServiceMock: FileStorageServiceMock!
    private var dateFormatterServiceMock: DateFormatterServiceMock!
    private var trip: Trip? = TripStub().getTripsStub().first!
    
    
    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        fileStorageServiceMock = FileStorageServiceMock()
        dateFormatterServiceMock = DateFormatterServiceMock()
        
        viewModel = .init(fileStorageService: fileStorageServiceMock,
                          dateFormatterService: dateFormatterServiceMock,
                          trip: trip!)
    }
    
    override func tearDown() {
        viewModel = nil
        fileStorageServiceMock = nil
        dateFormatterServiceMock = nil
        trip = nil
        super.tearDown()
    }
    
    
    // MARK: TESTS
    
    func testRetrieveImage() {
        // Act
        let data = viewModel.retrieveImage()
        
        // Assert
        XCTAssertEqual(data, Data())
    }
    
    func testTripInfo() {
        // Act
        let country = viewModel.country
        let currency = viewModel.currency
        let description = viewModel.description
        let date = viewModel.date
        
        // Assert
        XCTAssertEqual(country, "RUSSIA")
        XCTAssertEqual(currency, "₽")
        XCTAssertEqual(description, "Trip to Russia")
        XCTAssertEqual(date, "14 Sep 2022 - 14 Sep 2022")
    }
}
