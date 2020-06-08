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
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    init(grocery: Grocery) {
        super.init(nibName: nil, bundle: nil)
        initController(grocery: grocery)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private let mainView = GroceryItemView()
    private let viewModel = GroceryDetailsViewModel()
    
    // Private Methods
    
    private func initController(grocery: Grocery) {
        self.view = mainView
        viewModel.grocery = grocery

        mainView.groceryNameTextField.delegate = self
        mainView.priceDecimalField.delegate = self
        mainView.quantityDecimalField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        mainView.addGestureRecognizer(tap)
        
        mainView.groceryNameTextField.text = viewModel.name
        mainView.priceDecimalField.text = viewModel.price
        mainView.quantityDecimalField.text = viewModel.quantity
        mainView.unitSegmentedControl.selectedSegmentIndex = viewModel.unit.rawValue
        
        viewModel.totalBox.bindAndFire { [weak self] (total) in
            self?.mainView.totalValueLabel.text = total
        }
        
        mainView.groceryNameTextField.becomeFirstResponder()
        
        mainView.groceryNameTextField.addTarget(self, action: #selector(updateValues), for: .editingChanged)
        mainView.priceDecimalField.addTarget(self, action: #selector(updateValues), for: .editingChanged)
        mainView.quantityDecimalField.addTarget(self, action: #selector(updateValues), for: .editingChanged)
        mainView.unitSegmentedControl.addTarget(self, action: #selector(updateValues), for: .valueChanged)
        
        mainView.addButton.addTarget(self, action: #selector(touchedAddButton), for: .touchUpInside)
    }
    
    @objc private func hideKeyboard() {
        mainView.endEditing(true)
    }
    
    @objc private func updateValues() {
        let unitValue = mainView.unitSegmentedControl.selectedSegmentIndex
        let unit = Grocery.UnitOfMeasurement(rawValue: unitValue)!

        mainView.quantityDecimalField.numberFormatter.minimumFractionDigits = unit == .unit ? 0 : 3
        mainView.quantityDecimalField.numberFormatter.maximumFractionDigits = unit == .unit ? 0 : 3
        mainView.quantityDecimalField.editingChanged()
        
        let name = mainView.groceryNameTextField.text ?? ""
        let price = mainView.priceDecimalField.decimal
        let quantity = mainView.quantityDecimalField.decimal
        
        viewModel.grocery?.setValues(name, price: price, quantity: quantity, unit: unit)
    }
    
    @objc private func touchedAddButton() {
        updateValues()
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Text Field Delegate
extension GroceryItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case mainView.groceryNameTextField:
            mainView.priceDecimalField.becomeFirstResponder()
            
        case mainView.priceDecimalField:
            mainView.quantityDecimalField.becomeFirstResponder()
            
        default: break
        }
        
        return true
    }
}
