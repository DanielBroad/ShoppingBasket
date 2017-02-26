//
//  CheckoutViewController.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 25/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//
//  Display base currency total and convert to other currency

import UIKit

class CheckoutViewController: UIViewController {
    var basket : Basket?
    var currencies : Array<Currency> = []
    var baseCurrency : Currency?
    var alternateCurrency : Currency?
    
    @IBOutlet var currencyPicker : UIPickerView!
    @IBOutlet var baseCurrencyLabel : UILabel!
    @IBOutlet var baseCurrencyTotalLabel : UILabel!
    @IBOutlet var alternateCurrencyLabel : UILabel!
    @IBOutlet var alternateCurrencyTotalLabel : UILabel!
    
    @IBOutlet var alternateCurrencyCalculating : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Checkout", comment: "Checkout VC title")
        updateDisplay()
        CurrencyController.shared.allCurrencies { [weak self] (loadedcurrencies, error) in
            guard let `self` = self else { return }
            if let loadedcurrencies = loadedcurrencies {
                self.currencies = loadedcurrencies
                self.currencyPicker.reloadAllComponents()
                if let baseCurrency = CurrencyController.shared.currencyForCode(ProductController.shared.baseCurrency) {
                    self.baseCurrency = baseCurrency
                    if let index = loadedcurrencies.index(where: {$0 == baseCurrency}) {
                        self.currencyPicker .selectRow(index, inComponent: 0, animated: false)
                    }
                }
            } else if let error = error {
                SimpleAlert.show(fromViewController: self, title: NSLocalizedString("Could not load currency data", comment: "currency error"), message: error.localizedDescription)
            }
            
            self.updateDisplay()
        }
    }
    
    func updateDisplay() {
        if let baseCurrency = baseCurrency, let basket = basket {
            baseCurrencyLabel.text = baseCurrency.description
            baseCurrencyTotalLabel.text = CurrencyFormatter.string(from: basket.totalPriceInBaseCurrency(), with: baseCurrency)
        } else {
            baseCurrencyLabel.text = nil;
            baseCurrencyTotalLabel.text = nil;
        }
        
        if let alternateCurrency = alternateCurrency,
            let baseCurrency = baseCurrency,
            baseCurrency != alternateCurrency,
            let basket = basket {
                alternateCurrencyLabel.text = alternateCurrency.description
                alternateCurrencyTotalLabel.text = nil
                alternateCurrencyCalculating.startAnimating()
            
            CurrencyController.shared.getExchangeRate(source: baseCurrency, destination: alternateCurrency, completionHandler: { [weak self] (exchangeRate, error) in
                guard let `self` = self else { return }
                if let exchangeRate = exchangeRate {
                    self.alternateCurrencyTotalLabel.text = CurrencyFormatter.string(from: basket.totalPriceInBaseCurrency() * exchangeRate, with: baseCurrency)
                } else if let error = error {
                    self.alternateCurrencyTotalLabel.text = "?"
                    SimpleAlert.show(fromViewController: self, title: NSLocalizedString("Could not load exchange rate data", comment: "currency error"), message: error.localizedDescription)
                } else {
                    SimpleAlert.show(fromViewController: self, title: NSLocalizedString("Conversion not supported", comment: "currency error"), message: nil)
                }
                self.alternateCurrencyCalculating.stopAnimating()
            });
            
        } else {
            alternateCurrencyLabel.text = nil;
            alternateCurrencyTotalLabel.text = nil;
            alternateCurrencyCalculating.stopAnimating()
        }
        
    }

}

extension CheckoutViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
}

extension CheckoutViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        alternateCurrency = currencies[row]
        updateDisplay()
    }
}
