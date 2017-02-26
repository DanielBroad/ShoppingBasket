//
//  TestNetworkController.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 25/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import XCTest
@testable import ShoppingBasket

class TestNetworkController : CurrencyAPIRequests {
    func getCurrencies(completion: @escaping (CurrencyAPIResult) -> Void ) {
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "currencies", withExtension: "json")!, options: [])
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            completion(.success(jsonObject as! Dictionary<String,Any>))
        } catch let error {
            completion(.error(error))
        }

    }
    
    func getExchangeRate(completion: @escaping (CurrencyAPIResult) -> Void ) {
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "exchangerates", withExtension: "json")!, options: [])
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            completion(.success(jsonObject as! Dictionary<String,Any>))
        } catch let error {
            completion(.error(error))
        }
    }
}
