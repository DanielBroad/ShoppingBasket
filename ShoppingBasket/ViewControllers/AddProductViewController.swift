//
//  AddProductViewController.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 24/02/2017.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//
// This View Controller lets you add products to a basket

import UIKit

let cellID = "PRODUCTCELL"

typealias ProductsSelectedClosure = (Array<BasketItem>) -> Void

class AddProductViewController: UITableViewController {
    var productSelectedClosure: ProductsSelectedClosure
    
    var itemsToAdd : Array<BasketItem> = []
    var basket : Basket
    
    init(basket basketToUse: Basket, toAdd: @escaping ProductsSelectedClosure ) {
        productSelectedClosure = toAdd
        basket = basketToUse
        itemsToAdd = basket.emptyBasketItemsForAdd()
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Add Product", comment: "Add Product VC Title")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(add))
        
        tableView.register(UINib(nibName: "AddProductTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }

    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func add() {
        productSelectedClosure(itemsToAdd)
        dismiss(animated: true, completion: nil)
    }
}

extension AddProductViewController  { // : UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductController.shared.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AddProductTableViewCell
        cell.basketItem = itemsToAdd[indexPath.row]
        return cell
    }
}

extension AddProductViewController  { // : UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
