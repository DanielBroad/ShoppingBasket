//
//  ProductTests.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 25/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import XCTest
@testable import ShoppingBasket

class ProductTests: XCTestCase {
    
    func testValid() {
        let productDictionary : Dictionary <String,Any> = [
            "name" : "name",
            "unit" : "unit",
            "multipleunit" : "multipleunit",
            "price" : Double(1)
        ]
        
        do {
            let _ = try Product(withDictionary:productDictionary)
        }
        catch let error {
            XCTAssertNil(error, error.localizedDescription)
        }
    }
    
    func testInvalidName() {
        let invalidProductDictionary1 : Dictionary <String,Any> = [
            "unit" : "unit",
            "multipleunit" : "multipleunit",
            "price" : Double(1)
        ]
        let expectation = self.expectation(description: "fetch currencies")
        
        do {
            let product = try Product(withDictionary:invalidProductDictionary1)
            XCTAssertNil(product)
        }
        catch let error {
            print("\(error.localizedDescription)")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testInvalidUnit() {
        let invalidProductDictionary1 : Dictionary <String,Any> = [
            "name" : "name",
            "multipleunit" : "multipleunit",
            "price" : Double(1)
        ]
        let expectation = self.expectation(description: "fetch currencies")
        
        do {
            let product = try Product(withDictionary:invalidProductDictionary1)
            XCTAssertNil(product)
        }
        catch let error {
            print("\(error.localizedDescription)")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testInvalidPrice() {
        let invalidProductDictionary1 : Dictionary <String,Any> = [
            "name" : "name",
            "unit" : "unit",
            "multipleunit" : "multipleunit",
        ]
        let expectation = self.expectation(description: "fetch currencies")
        
        do {
            let product = try Product(withDictionary:invalidProductDictionary1)
            XCTAssertNil(product)
        }
        catch let error {
            print("\(error.localizedDescription)")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testInvalidMultiUnit() {
        let invalidProductDictionary1 : Dictionary <String,Any> = [
            "name" : "name",
            "unit" : "unit",
            "price" : Double(1)
        ]
        
        do {
            let product = try Product(withDictionary:invalidProductDictionary1)
            XCTAssert(product.unit == product.multipleunit)
        }
        catch let error {
            XCTAssertNil(error, error.localizedDescription)
        }
    }
}
