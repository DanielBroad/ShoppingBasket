//
//  AddProductTableViewCell.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 25/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//
//  Cell to display product, number and +- stepper

import UIKit

class AddProductTableViewCell: UITableViewCell {

    @IBOutlet var productLabel : UILabel!
    @IBOutlet var quantityLabel : UILabel!
    @IBOutlet var stepper : UIStepper!
    
    override func awakeFromNib() {
        selectionStyle = .none
        quantityLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: 0)
    }
    
    var basketItem : BasketItem? {
        didSet {
            display()
            if let basketItem = basketItem {
                stepper.value = Double(basketItem.quantity)
            }
        }
    }
    
    func display() {
        if let basketItem = basketItem {
            productLabel.text = basketItem.product.name
            quantityLabel.text = basketItem.quantityWithUnit()
        }
    }
    
    @IBAction func stepperChanged(sender : UIStepper) {
        if let basketItem = basketItem {
            basketItem.quantity = Int(sender.value)
            display()
        }
    }
}
