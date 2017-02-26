//
//  BasketViewController.swift
//  ShoppingBasket
//
//  Created by Daniel Broad on 24/02/2017.
//
//  This View Controller displays a list of basket items
//

import UIKit

class ShoppingBasketViewController: UIViewController {

    @IBOutlet var tableView : UITableView!
    
    var basket : Basket
    
    required init?(coder aDecoder: NSCoder) {
        basket = Basket()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Basket", comment: "Basket VC Title")
        navigationController!.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension ShoppingBasketViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // edit the row in future
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // remove a basket item
        if editingStyle == .delete {
            let basketItem = basket.items[indexPath.row]
            if (basket.remove(item: basketItem)) {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            tableView.setEditing(false, animated: true)
        }
    }
}

extension ShoppingBasketViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "BASKETCELL"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
        }
        if let cell = cell {
            let basketItem = basket.items[indexPath.row]
            cell.textLabel!.text = basketItem.product.name
            cell.detailTextLabel!.text = basketItem.quantityWithUnit()
        }
        return cell!
    }
}

//Mark : My Actions
extension  ShoppingBasketViewController {
    @IBAction func checkout(sender : Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let checkoutViewController = storyboard.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
        checkoutViewController.basket = basket
        self.navigationController?.pushViewController(checkoutViewController, animated: true)
    }
    
    @IBAction func add(sender: Any) {
        let add = AddProductViewController(basket: basket) { (items) in self.basket.add(items: items) }
        present(UINavigationController(rootViewController: add), animated: true, completion: nil)
    }
    
    @IBAction func clear(sender: Any) {
        basket.clear()
        tableView.reloadData()
    }
}
