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
    
    let groceryListViewController = GroceryListViewController()
    let groceryItemViewController = GroceryItemViewController()
    
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
    // Private Types
    // Private Properties
    // Private Methods
    
    private func initController() {
        viewControllers = [groceryListViewController]
    }
}
