//
//  NetworkController.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 25/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//
//  Network Requests for the currency API

import UIKit

private struct URLs {
    static let Currency : URL = URL(string: "http://apilayer.net/api/list?access_key=5f85483f5d635c79867e3ccb2c8d5ddd")!
    static let LiveQuotes : URL = URL(string: "http://apilayer.net/api/live?access_key=5f85483f5d635c79867e3ccb2c8d5ddd")!
}

public enum CurrencyAPIResult { // calls can succeed or fail!
    case success(Dictionary<String,Any>)
    case error(Error)
}

public protocol CurrencyAPIRequests { // calls supported
    func getCurrencies(completion: @escaping (CurrencyAPIResult) -> Void );
    func getExchangeRate(completion: @escaping (CurrencyAPIResult) -> Void );
}

class NetworkController : CurrencyAPIRequests {
    
    var foregroundSession : URLSession
    
    init() {
        foregroundSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func restCall(url : URL,completion: @escaping (CurrencyAPIResult) -> Void ) {
        let task = self.foregroundSession.dataTask(with: url, completionHandler: { (data : Data?, response : URLResponse?, error : Error?) -> Void in
            if let error = error {
                completion(.error(error))
            } else if let data = data {
                do {
                    let decoded = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
                    completion(.success(decoded))
                } catch let e {
                    let string = String(data: data, encoding: String.Encoding.utf8)
                    print("\(string)")
                    completion(.error(e))
                }
            }
        });
        task.resume()
    }
    
    func getCurrencies(completion: @escaping (CurrencyAPIResult) -> Void ) {
        restCall(url: URLs.Currency, completion: completion)
    }
    
    func getExchangeRate(completion: @escaping (CurrencyAPIResult) -> Void ) {
        restCall(url: URLs.LiveQuotes, completion: completion)
    }
}
