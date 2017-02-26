//
//  CurrencyFormatter.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 25/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//
// Display number as a currency

import UIKit

class CurrencyFormatter {
    
    class func string(from amount: Double, with currency: Currency) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency.code
        return formatter.string(from: NSNumber(value: amount)) ?? "NaN"
    }
}
