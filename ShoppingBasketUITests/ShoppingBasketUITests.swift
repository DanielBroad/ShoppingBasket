//
//  ShoppingBasketUITests.swift
//  ShoppingBasketUITests
//
//  Created by Daniel Broad on 24/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import XCTest

class ShoppingBasketUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        XCUIApplication().launch()
        XCUIDevice.shared().orientation = .portrait
    }
    
    func testSmokeTest() {
        // Use recording to get started writing UI tests.
        let app = XCUIApplication()
        let addItemsButton = app.navigationBars["Basket"].buttons["Add Items"]
        addItemsButton.tap()
        
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"Peas").buttons["Increment"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"Eggs").buttons["Increment"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"Milk").buttons["Increment"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"Beans").buttons["Increment"].tap()
        
        app.navigationBars["Add Product"].buttons["Save"].tap()
        
        app.toolbars.buttons["Checkout"].tap()
        app.pickers.children(matching: .pickerWheel).element.adjust(toPickerWheelValue: "Ukrainian Hryvnia")
    
    }
    
}
