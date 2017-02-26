//
//  CurrencyControllerTests.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 25/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import XCTest
@testable import ShoppingBasket

class CurrencyControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        CurrencyController.shared.networkController = TestNetworkController()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCurrencies() {
        let expectation = self.expectation(description: "fetch currencies")
        CurrencyController.shared.allCurrencies { (currency, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(currency)
            expectation.fulfill()
        };
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testLookups() {
        let tests = ["GBP","USD"]
        
        let expectation = self.expectation(description: "fetch currencies")
        CurrencyController.shared.allCurrencies { (currency, error) in
            for test in tests {
                let currency = CurrencyController.shared.currencyForCode(test)
                XCTAssertNotNil(currency)
                XCTAssert(currency!.code == test)
            }
            expectation.fulfill()
        };
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testConversion() {
        let expectation = self.expectation(description: "fetch currencies")
        CurrencyController.shared.allCurrencies { (currency, error) in
            let fromcurrency = CurrencyController.shared.currencyForCode("USD")
            let tocurrency = CurrencyController.shared.currencyForCode("GBP")
            CurrencyController.shared.getExchangeRate(source: fromcurrency!, destination: tocurrency!) { (exchangeRate, error) in
                XCTAssertNil(error)
                XCTAssertNotNil(exchangeRate)
                XCTAssertTrue(round(exchangeRate!*100) == round(0.8024*100), "\(exchangeRate)")
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            let expectation = self.expectation(description: "fetch currencies")
            CurrencyController.shared.allCurrencies { (currency, error) in
                for _ in 1...100 {
                    let currency = CurrencyController.shared.currencyForCode("GBP")
                    XCTAssertNotNil(currency)
                }
                expectation.fulfill()
            }
            self.waitForExpectations(timeout: 5.0, handler: nil)
        }
    }
    
}
