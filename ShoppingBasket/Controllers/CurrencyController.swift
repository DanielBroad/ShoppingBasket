//
//  CurrencyController.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 24/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//
//  Stores the list of currencies and does exchange rate conversion

import UIKit

private struct APIDictionaryKey {
    static let Currencies = "currencies"
    static let Quotes = "quotes"
}

final class CurrencyController {
    static let shared: CurrencyController = CurrencyController()
    
    var networkController : CurrencyAPIRequests = NetworkController()
    
    private var currencies : Array<Currency>?;
    
    private init() {}
    
    func allCurrencies(completionHandler: @escaping (Array<Currency>?, Error?) -> ()) {
        // fetch list of currencies from the network IF we don't have it and parse out the JSON
        if let currencies = currencies {
            completionHandler(currencies, nil)
        } else {
            // TODO: store and nest completion handlers to avoid race condition where network requests are duplicated if called in quick succession
            networkController.getCurrencies() { (result) in
                switch result {
                case let .success(jsonDictionary):
                    if let currencyDictionary = jsonDictionary[APIDictionaryKey.Currencies] as? Dictionary<String, String> {
                        var newCurrencies : Array<Currency> = []
                        for (key, description) in currencyDictionary {
                            newCurrencies.append(Currency(code: key, description : description))
                        }
                        self.currencies = newCurrencies.sorted(by: { (currency1, currency2) -> Bool in
                            return currency1.description < currency2.description
                        })
                    }
                    DispatchQueue.main.async {
                        completionHandler(self.currencies,nil)
                    }
                case let .error(error):
                    completionHandler(nil,error)
                }
            };
        }
    }
    
    func currencyForCode(_ code: String) -> Currency? {
        // find a currency object by currency code
        guard let currencies = currencies else { return nil }
        
        for currency in currencies {
            if currency.code == code {
                return currency
            }
        }

        return nil
    }
    
    func getExchangeRate(source: Currency, destination: Currency, completionHandler: @escaping (Double?, Error?) -> () ) {
        // fetch the remote exchange rates and find out the current exchange rate
        networkController.getExchangeRate() { (result) in
            switch result {
            case let .success(jsonDictionary):
                if let jsonArray = jsonDictionary[APIDictionaryKey.Quotes] as? Dictionary<String, Any> {
                    for (key, rate) in jsonArray {
                        if key == "\(source.code)\(destination.code)" {
                            DispatchQueue.main.async {
                                completionHandler(rate as? Double,nil)
                            }
                            return;
                        }
                    }
                }
                DispatchQueue.main.async {
                    completionHandler(nil,nil)
                }
            case let .error(error):
                completionHandler(nil,error)
            }
        };
    }
}
