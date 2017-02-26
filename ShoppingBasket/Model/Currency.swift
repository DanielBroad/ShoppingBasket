//
//  Currency.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 24/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//
//  Currency has international code and a description

import UIKit

func ==(l: Currency, r: Currency) -> Bool {
    return l.code == r.code
}

func !=(l: Currency, r: Currency) -> Bool {
    return l.code != r.code
}

struct Currency {
    var code : String
    var description : String
    
    init(code _code: String, description _description: String) {
        code = _code
        description = _description
    }
    
}
