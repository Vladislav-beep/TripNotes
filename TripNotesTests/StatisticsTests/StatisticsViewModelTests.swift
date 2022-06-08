//
//  StatisticsViewModelTests.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 08.06.2022.
//

import XCTest

class StatisticsViewModelTests: XCTestCase {
    
    // MARK: Private
    
    private var viewModel: StatisticsViewModel!
    private var notes = NoteStub().getNotes()
    private var currency = "$"
    
    
    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        
        viewModel = .init(notes: notes, currency: currency)
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    
    // MARK: TESTS
    
    func testExample() throws {
        // Arrange
        let expectedTransportText = "Transport: 2.56 \(currency)"
        let expectedHotelText = "Hotels: 0 \(currency)"
        let expectedFoodText = "Food: 78.35 \(currency)"
        let expectedActivityText = "Activity: 0 \(currency)"
        let expectedPurchasesText = "Purchases: 0 \(currency)"
        let expectedOtherText = "Other: 0 \(currency)"
        
        // Act
        let transportText = viewModel.trasportText
        let hotelText = viewModel.hotelText
        let foodText = viewModel.foodText
        let activityText = viewModel.activityText
        let purchasesText = viewModel.purchasesText
        let otherText = viewModel.otherText
        
        // Assert
        XCTAssertEqual(expectedTransportText, transportText)
        XCTAssertEqual(expectedHotelText, hotelText)
        XCTAssertEqual(expectedFoodText, foodText)
        XCTAssertEqual(expectedActivityText, activityText)
        XCTAssertEqual(expectedPurchasesText, purchasesText)
        XCTAssertEqual(expectedOtherText, otherText)
    }
}
