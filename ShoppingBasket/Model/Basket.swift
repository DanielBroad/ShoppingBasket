//
//  Basket.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 24/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//
// Basket holds an array of items to be "checked out"
// Basket item is a product with a quantity

import UIKit

// MARK: BasketItem
class BasketItem {
    var product : Product
    var quantity : Int = 0
    
    init(product: Product) {
        self.product = product
    }
    
    func quantityWithUnit() -> String {
        switch quantity {
        case 0:
            return ""
        case 1:
            return "\(quantity) \(product.unit)";
        default:
            return "\(quantity) \(product.multipleunit)";
        }
    }
}

extension BasketItem : CustomStringConvertible {
    var description: String {
        return "\(type(of: self)) \(product.name) \(quantity) each \(product.unit)"
    }
}

// MARK: Basket
class Basket : NSObject {
    var items : Array<BasketItem> = []
    
    func emptyBasketItemsForAdd() -> Array<BasketItem> {
        var emptyArray : Array<BasketItem> = [];
        for product in ProductController.shared.products {
            emptyArray.append(BasketItem(product: product))
        }
        return emptyArray
    }
}


// MARK: Basket Manipulation
extension Basket {
    func add(item: BasketItem) {
        // find any current item
        for existingitem in items {
            if existingitem.product == item.product {
                existingitem.quantity += item.quantity
                return;
            }
        }
        
        if (item.quantity > 0 ) {
            items.append(item)
        }
        
    }
    
    func add(items itemsToAdd: Array<BasketItem>) {
        for item in itemsToAdd {
            add(item: item)
        }
    }
    
    func remove(item: BasketItem) -> Bool {
        for i in 0...items.count-1 {
            let existingItem = items[i];
            if existingItem.product == item.product {
                items.remove(at: i)
                return true
            }
        }
        return false
    }
    
    func clear() {
        items.removeAll()
    }
}

// MARK: Basket Calculations
extension Basket {
    func totalPriceInBaseCurrency() -> Double {
        var total : Double = 0
        for existingitem in items {
            total += Double(existingitem.quantity) * existingitem.product.price
        }
        return total
    }
}
