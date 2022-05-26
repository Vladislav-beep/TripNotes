//
//  NoteCellViewModelTests.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 22.05.2022.
//

import XCTest

class NoteCellViewModelTests: XCTestCase {
    
    // MARK: Private
    
    private var viewModel: NoteCellViewModel!
    private var fireBaseServiceMock: FireBaseServiceMock!
    private var dateFormatterServiceMock: DateFormatterServiceMock!
    private var trip: Trip? = TripStub().getTripsStub().first!
    private var tripNote: TripNote? = NoteStub().getNotes().first!
    private var currency: String? = "$"
    private var userId: String? = "123000"
    
    
    // MARK: Lifecycle

    override func setUp() {
        super.setUp()
        fireBaseServiceMock = FireBaseServiceMock()
        dateFormatterServiceMock = DateFormatterServiceMock()
        
        viewModel = .init(tripNote: tripNote!,
                          currency: currency!,
                          trip: trip!,
                          isInfoShown: false,
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
        tripNote = nil
        currency = nil
        super.tearDown()
    }
    
    
    // MARK: TESTS

    func testGetTripId() {
        // Arrange
        let expectedTripId = "123"
        
        // Act
        let tripId = viewModel.getTripId()
        
        // Assert
        XCTAssertEqual(tripId, expectedTripId)
    }
    
    func testGetNoteId() {
        // Arrange
        let expectedNoteId = "0987654"
        
        // Act
        let noteId = viewModel.getNoteId()
        
        // Assert
        XCTAssertEqual(noteId, expectedNoteId)
    }
}
