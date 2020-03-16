//
//  GroceryDetailsViewController.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import UIKit

class GroceryItemViewController: UIViewController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    weak var grocery: Grocery? {
        didSet {
            if let grocery = self.grocery {
                itemView.fillView(grocery)
            }
        }
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        itemView.groceryNameTextField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        itemView.clearView()
        grocery = nil
    }
    
    // Private Types
    // Private Properties
    
    private let itemView = GroceryItemView()
    
    // Private Methods
    
    private func initController() {
        self.view = itemView
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
        itemView.addButton.addTarget(self, action: #selector(touchedAddButton), for: .touchUpInside)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func touchedAddButton() {
        let name = itemView.groceryNameTextField.text ?? ""
        let price = itemView.priceDecimalField.decimal
        let quantity = itemView.quantityDecimalField.decimal
        let unitValue = itemView.unitSegmentedControl.selectedSegmentIndex
        let unit = Grocery.UnitOfMeasurement(rawValue: unitValue)!
        
        if let grocery = self.grocery {
            grocery.setValues(name, price: price, quantity: quantity, unit: unit)
        }
        else {
            let newGrocery = Grocery(name, price: price, quantity: quantity, unit: unit)
            Grocery.list.append(newGrocery)
        }
        
        dismiss(animated: true, completion: nil)
    }
}
