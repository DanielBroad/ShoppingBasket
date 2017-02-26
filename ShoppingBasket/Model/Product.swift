//
//  Product.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 24/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//
//  Products are in a plist

import UIKit

private struct ProductDictionaryKeys {
    static let Unit = "unit"
    static let MultipleUnit = "multipleunit"
    static let Name = "name"
    static let Price = "price"
}


enum ProductError: Error {
    case invalidData
}

func ==(l: Product, r: Product) -> Bool {
    return l.name == r.name
}

class Product {
    var name : String = ""
    var unit : String = ""
    var multipleunit : String = ""
    var price : Double = 0
    
    init(withDictionary productData : Dictionary<String, Any>) throws {
        if let name = productData[ProductDictionaryKeys.Name] as? String {
            self.name = name
        }
        if let unit = productData[ProductDictionaryKeys.Unit] as? String {
            self.unit = unit
        }
        if let price = productData[ProductDictionaryKeys.Price] as? Double {
            self.price = price
        }
        if let multipleunit = productData[ProductDictionaryKeys.MultipleUnit] as? String {
            self.multipleunit = multipleunit
        } else {
            self.multipleunit = self.unit
        }
        
        guard name != "", unit != "", multipleunit != "", price != 0 else {
            throw ProductError.invalidData
        }
    
    }
    
}

extension Product : CustomStringConvertible {
    var description: String {
        return "\(type(of: self)) \(name) \(price) each \(unit)"
    }
}
