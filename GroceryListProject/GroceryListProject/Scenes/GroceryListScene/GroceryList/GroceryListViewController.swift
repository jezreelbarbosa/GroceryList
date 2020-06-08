//
//  GroceryListViewController.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import UIKit

protocol GroceryListDelegate: class {
    func touchAddBarButtonItem()
    func didSelectGrocery(_ grocery: Grocery)
}

final class GroceryListViewController: UIViewController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    weak var delegate: GroceryListDelegate?
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    init() {
        super.init(nibName: nil, bundle: nil)
        initController()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    
    override func willMove(toParent parent: UIViewController?) {
        mainView.customizeNavigationBar(self)
    }
    
    // Private Types
    // Private Properties
    
    private let mainView = GroceryListView()
    
    // Private Methods
    
    private func initController() {
        self.view = mainView
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(GroceryTableViewCell.self, forCellReuseIdentifier: GroceryTableViewCell.reuseIdentifier)
        mainView.tableView.register(GroceryListFooterView.self, forHeaderFooterViewReuseIdentifier: GroceryListFooterView.reuseIdentifier)
        
        mainView.addBarButtonItem.target = self
        mainView.addBarButtonItem.action = #selector(touchAddBarButtonItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(groceryListAddedNewItem), name: Grocery.listAddedNewItemNN, object: nil)
    }
    
    @objc private func touchAddBarButtonItem() {
        delegate?.touchAddBarButtonItem()
    }
    
    @objc private func groceryListAddedNewItem() {
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
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
        delegate?.didSelectGrocery(Grocery.list[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: GroceryListFooterView.reuseIdentifier) as! GroceryListFooterView
        
        footer.fill()
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return GroceryListFooterView.rowHeight
    }
}
