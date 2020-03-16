//
//  GroceryListViewController.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import UIKit

class GroceryListViewController: UIViewController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initController()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    
    override func willMove(toParent parent: UIViewController?) {
        groceryView.customizeNavigationBar(self)
    }
    
    // Private Types
    // Private Properties
    
    private let groceryView = GroceryListView()
    
    // Private Methods
    
    private func initController() {
        self.view = groceryView
        
        groceryView.tableView.dataSource = self
        groceryView.tableView.delegate = self
        groceryView.tableView.register(GroceryTableViewCell.self, forCellReuseIdentifier: GroceryTableViewCell.reuseIdentifier)
        groceryView.tableView.register(GroceriesFooterView.self, forHeaderFooterViewReuseIdentifier: GroceriesFooterView.reuseIdentifier)
        
        groceryView.addBarButtonItem.target = self
        groceryView.addBarButtonItem.action = #selector(addBarButtonDidTouchUp)
        
        NotificationCenter.default.addObserver(self, selector: #selector(groceryListAddedNewItem), name: Grocery.listAddedNewItemNN, object: nil)
    }
    
    @objc private func addBarButtonDidTouchUp() {
        if let navController = navigationController as? GroceriesNavigationController {
            present(navController.groceryItemViewController, animated: true, completion: nil)
        }
    }
    
    @objc private func groceryListAddedNewItem() {
        DispatchQueue.main.async {
            self.groceryView.tableView.reloadData()
        }
    }
}

// MARK: - Table View Delegate
extension GroceryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Grocery.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroceryTableViewCell.reuseIdentifier) as! GroceryTableViewCell
        
        cell.fill(Grocery.list[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GroceryTableViewCell.rowHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Grocery.list.remove(at: indexPath.row)
            DispatchQueue.main.async {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let navController = navigationController as? GroceriesNavigationController {
            navController.groceryItemViewController.grocery = Grocery.list[indexPath.row]
            present(navController.groceryItemViewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: GroceriesFooterView.reuseIdentifier) as! GroceriesFooterView
        
        footer.fill(Grocery.listTotalString)
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return GroceriesFooterView.rowHeight
    }
}
