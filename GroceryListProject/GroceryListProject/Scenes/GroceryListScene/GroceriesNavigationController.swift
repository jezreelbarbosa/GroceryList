//
//  GroceriesNavigationController.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import UIKit

class GroceriesNavigationController: UINavigationController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    init() {
        super.init(rootViewController: groceryListViewController)
        initController()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private let groceryListViewController = GroceryListViewController()
    
    // Private Methods
    
    private func initController() {
        groceryListViewController.delegate = self
    }
}

extension GroceriesNavigationController: GroceryListDelegate {
    func touchAddBarButtonItem() {
        DispatchQueue.main.async {
            let newGrocery = Grocery()
            let groceryItemViewController = GroceryItemViewController(grocery: newGrocery)
            self.present(groceryItemViewController, animated: true) {
                Grocery.list.append(newGrocery)
            }
        }
    }
    
    func didSelectGrocery(_ grocery: Grocery) {
        DispatchQueue.main.async {
            let groceryItemViewController = GroceryItemViewController(grocery: grocery)
            self.present(groceryItemViewController, animated: true, completion: nil)
        }
    }
}
