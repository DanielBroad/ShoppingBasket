//
//  CurrencyFormatterTests.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 25/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import XCTest
@testable import ShoppingBasket

class CurrencyFormatterTests: XCTestCase {
    func testZero() {
        let currency = Currency(code: "USD", description: "USD Dollar")
        XCTAssert(CurrencyFormatter.string(from: 0.0, with: currency) == "$0.00")
    }
    
    func testRoundDown() {
        let currency = Currency(code: "USD", description: "USD Dollar")
        XCTAssert(CurrencyFormatter.string(from: 0.9847329723894, with: currency) == "$0.98")
    }
    
    func testRoundUp() {
        let currency = Currency(code: "USD", description: "USD Dollar")
        XCTAssert(CurrencyFormatter.string(from: 0.9857329723894, with: currency) == "$0.99")
    }
    
    func testGBP() {
        let currency = Currency(code: "GBP", description: "Pound")
        let result = CurrencyFormatter.string(from: 15.78, with: currency)
        XCTAssert(result == "£15.78",result)
    }
    
    func testUnknownCurrency() {
        let currency = Currency(code: "XYZ", description: "unknown currency")
        let result = CurrencyFormatter.string(from: 15.78, with: currency)
        XCTAssert(result == "XYZ15.78",result)
    }
    
    func testPerformance() {
        self.measure {
            let currency = Currency(code: "USD", description: "USD Dollar")
            XCTAssert(CurrencyFormatter.string(from: 0.0, with: currency) == "$0.00")
        }
    }
}
