//
//  ProductController.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 24/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//
// Serves up a list of products from a plist

import UIKit

private let PlistFileName = "Products"

private struct ProductKeys {
    static let Products = "Products"
    static let BaseCurrency = "BaseCurrency"
}

final class ProductController {
    
    private var _products : Array<Product> = []
    private var _baseCurrency : String = "USD"
    
    static let shared: ProductController = ProductController()
    
    private init() {
        guard let path = Bundle.main.path(forResource: PlistFileName, ofType: "plist"),
            let plistDictionary = NSDictionary(contentsOfFile: path) else { assertionFailure("NO PRODUCT PLIST INCLUDED") ; return }
        
        guard let productArray = plistDictionary.object(forKey: ProductKeys.Products) as? NSArray else {
            assertionFailure("NO PRODUCT LIST"); return
        }
        
        let products : [Product?] = productArray.map({ (eachproduct) in
            if let productDictionary = eachproduct as? Dictionary<String,Any>,
                    let product = try? Product(withDictionary: productDictionary) {
                return product
            } else {
                assertionFailure("INVALID PRODUCT DATA")
                return nil
            }
        })
        
        _products = products.flatMap{ $0 } // remove optionals
        
        if let plistBaseCurrency = plistDictionary.object(forKey: ProductKeys.BaseCurrency) as? String {
            _baseCurrency = plistBaseCurrency
        }
        
    }
    
    var products : Array<Product> {
        return _products
    }
    
    var baseCurrency : String {
        return _baseCurrency
    }
}
