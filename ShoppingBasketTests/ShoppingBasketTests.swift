//
//  ShoppingBasketTests.swift
//  ShoppingBasketTests
//
//  Created by Daniel Broad on 24/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import XCTest
@testable import ShoppingBasket

class ShoppingBasketTests: XCTestCase {
    
    var basket = Basket()
    
    override func setUp() {
        super.setUp()
        
        basket = Basket()
        
        let items = basket.emptyBasketItemsForAdd()
        for item in items {
            item.quantity = 1
        }
        basket.add(items: items)
    }
    
    func testInitialState() {
        XCTAssertTrue(basket.items.count == 4)
        XCTAssertTrue(basket.totalPriceInBaseCurrency() > 0)
    }
    
    func testRemove() {
        let initialCount = basket.items.count
        let initialTotal = basket.totalPriceInBaseCurrency()
        
        let item = basket.items[1]
        
        XCTAssertTrue(basket.remove(item: item))
        
        XCTAssertTrue(basket.items.count == initialCount - 1, "\(basket.items.count)")
        XCTAssertTrue(basket.totalPriceInBaseCurrency() == initialTotal - item.product.price,
                      "\(basket.totalPriceInBaseCurrency())")
        
        XCTAssertFalse(basket.remove(item: item))
    }
    
    func testAdd() {
        let initialCount = basket.items.count
        let initialTotal = basket.totalPriceInBaseCurrency()
        
        let item = basket.items[1]
        
        basket.add(item: item)
        
        XCTAssertTrue(basket.items.count == initialCount, "\(basket.items.count)")
        XCTAssertTrue(basket.totalPriceInBaseCurrency() == initialTotal + item.product.price,
                      "\(basket.totalPriceInBaseCurrency())")
    }
    
    func testClear() {
        basket.clear()
        
        XCTAssertTrue(basket.items.count == 0, "\(basket.items.count)")
        XCTAssertTrue(basket.totalPriceInBaseCurrency() == 0,
                      "\(basket.totalPriceInBaseCurrency())")
    }
}
