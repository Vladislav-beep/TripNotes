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
    private let trip = TripStub().getTripsStub().first!
    
    
    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        fileStorageServiceMock = FileStorageServiceMock()
        dateFormatterServiceMock = DateFormatterServiceMock()
        
        viewModel = .init(fileStorageService: fileStorageServiceMock,
                          dateFormatterService: dateFormatterServiceMock,
                          trip: trip)
    }
    
    override func tearDown() {
        viewModel = nil
        fileStorageServiceMock = nil
        dateFormatterServiceMock = nil
        super.tearDown()
    }
    
    
    // MARK: TESTS
    
    func testExample() {
        let data = viewModel.retrieveImage()
        
        XCTAssertEqual(data, Data())
    }
    
    func testExample1() {
        let country = viewModel.country
        
        XCTAssertEqual(country, "RUSSIA")
    }
    
}
