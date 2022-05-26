//
//  NewTripViewModelTests.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 22.05.2022.
//

import XCTest

class NewTripViewModelTests: XCTestCase {

    // MARK: Private
    
    private var viewModel: NewTripViewModel!
    private var fireBaseServiceMock: FireBaseServiceMock!
    private var fileStorageServiceMock: FileStorageServiceMock!
    private var userId: String? = "XXX"
    private var tripId: String?  = "00000"
    
    
    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        fireBaseServiceMock = FireBaseServiceMock()
        fileStorageServiceMock = FileStorageServiceMock()
        
        viewModel = .init(tripId: tripId!,
                          userId: userId!,
                          fireBaseService: fireBaseServiceMock,
                          fileStorageService: fileStorageServiceMock)
    }
    
    override func tearDown (){
        viewModel = nil
        fireBaseServiceMock = nil
        fileStorageServiceMock = nil
        userId = nil
        tripId = nil
        super.tearDown()
    }
    
    
    // MARK: TESTS
    
    func testRetrieveImage() {
        // Act
        let data = viewModel.retrieveImage()
        
        // Assert
        XCTAssertEqual(data, Data())
    }
    
    func testDownloadTrip() {
        // Act
        viewModel.downloadTrip()
        
        // Assert
        XCTAssertEqual(viewModel.currency, "₽")
        XCTAssertEqual(viewModel.country, "Russia")
        XCTAssertEqual(viewModel.description, "Trip to Russia")
        XCTAssertEqual(viewModel.tripId, "00000")
    }
}
