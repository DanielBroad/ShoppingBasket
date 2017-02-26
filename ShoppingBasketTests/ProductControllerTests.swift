//
//  ProductControllerTests.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 25/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import XCTest
@testable import ShoppingBasket

class ProductControllerTests: XCTestCase {
    
    func testProducts() {
        let products = ProductController.shared.products
        XCTAssertNotNil(products)
        XCTAssert(products.count == 4,"\(products.count)")
    }
    
    func testBaseCurrency() {
        let baseCurrency = ProductController.shared.baseCurrency
        XCTAssertNotNil(baseCurrency)
    }
    
    func testPerformance() {
        self.measure {
            let products = ProductController.shared.products
            XCTAssertNotNil(products)
        }
    }
    
}
