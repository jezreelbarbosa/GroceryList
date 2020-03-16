//
//  GroceryDetailsView.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import UIKit
import Stevia

class GroceryItemView: UIView {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    let groceryNameTextField = UITextField()
    
    let priceDecimalField = UIDecimalField()
    let quantityDecimalField = UIDecimalField()
    
    let unitSegmentedControl = UISegmentedControl()
    let addButton = UIButton(type: .custom)
    
    // Public Methods
    
    func fillView(_ grocery: Grocery) {
        groceryNameTextField.text = grocery.name
        priceDecimalField.text = grocery.priceString
        quantityDecimalField.text = grocery.quantityString
        unitSegmentedControl.selectedSegmentIndex = grocery.unit.rawValue
        totalValueLabel.text = grocery.totalString
        
        unitSegmentedControl.sendActions(for: .valueChanged)
        priceDecimalField.sendActions(for: .editingChanged)
        quantityDecimalField.sendActions(for: .editingChanged)
    }
    
    func clearView() {
        groceryNameTextField.text = nil
        priceDecimalField.text = nil
        quantityDecimalField.text = nil
        unitSegmentedControl.selectedSegmentIndex = 0
        
        unitSegmentedControl.sendActions(for: .valueChanged)
        priceDecimalField.sendActions(for: .editingChanged)
        quantityDecimalField.sendActions(for: .editingChanged)
        updateTotalValue()
    }
    
    // Initialisation/Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private let priceTextLabel = UILabel()
    private let quantityTextLabel = UILabel()
    
    private let totalTextLabel = UILabel()
    private let totalValueLabel = UILabel()
    private let totalNumberFormatter = NumberFormatter()
    
    // Private Methods
    
    @objc private func selectedSegmentChanged() {
        quantityDecimalField.fractionDigits = (unitSegmentedControl.selectedSegmentIndex == 0) ? 0 : 3
        updateTotalValue()
    }
    
    @objc private func updateTotalValue() {
        let factor: Decimal = unitSegmentedControl.selectedSegmentIndex == 1 ? 0.1 : 1
        let total = priceDecimalField.decimal * quantityDecimalField.decimal / factor
        totalValueLabel.text = totalNumberFormatter.string(for: total)
    }
    
    private func renderSuperView() {
        sv(
            groceryNameTextField,
            priceTextLabel,
            priceDecimalField,
            quantityTextLabel,
            quantityDecimalField,
            unitSegmentedControl,
            totalTextLabel,
            totalValueLabel,
            addButton
        )
    }
    
    private func renderLayout() {
        groceryNameTextField.top(36).left(16).right(16)
        
        priceDecimalField.Top == groceryNameTextField.Bottom + 8
        align(horizontally: priceTextLabel, priceDecimalField)
        priceTextLabel.left(16).Right == priceDecimalField.right(16).Left - 8
        priceTextLabel.leftConstraint?.priority = .required
        priceTextLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        unitSegmentedControl.left(16).height(36).right(16).Top == priceDecimalField.Bottom + 8
        
        quantityDecimalField.Top == unitSegmentedControl.Bottom + 8
        align(horizontally: quantityTextLabel, quantityDecimalField)
        quantityTextLabel.left(16).Right == quantityDecimalField.Left - 8
        quantityDecimalField.right(16)
        quantityTextLabel.leftConstraint?.priority = .required
        quantityTextLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        addButton.Top == quantityDecimalField.Bottom + 16
        align(horizontally: totalTextLabel, totalValueLabel, addButton)
        totalTextLabel.left(16).Right == totalValueLabel.Left - 8
        totalValueLabel.Right == addButton.width(112).height(36).right(16).Left - 8
        totalTextLabel.leftConstraint?.priority = .required
        totalTextLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.backgroundColor = .appBackground
        }
        groceryNameTextField.style { (s) in
            s.placeholder = NSLocalizedString("GroceryItemView.groceryNameTextField.placeholder", comment: "")
            s.borderStyle = .roundedRect
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = .appLabel
        }
        
        priceTextLabel.style { (s) in
            s.text = NSLocalizedString("GroceryItemView.priceTextLabel.Text", comment: "")
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = .appLabel
        }
        priceDecimalField.style { (s) in
            s.fractionDigits = 2
            s.numberStyle = .currency
            s.borderStyle = .roundedRect
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = .appLabel
            s.addTarget(self, action: #selector(updateTotalValue), for: .editingChanged)
        }
        
        quantityTextLabel.style { (s) in
            s.text = NSLocalizedString("GroceryItemView.quantityTextLabel.Text", comment: "")
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = .appLabel
        }
        quantityDecimalField.style { (s) in
            s.fractionDigits = 0
            s.numberStyle = .decimal
            s.borderStyle = .roundedRect
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = .appLabel
            s.addTarget(self, action: #selector(updateTotalValue), for: .editingChanged)
        }
        
        unitSegmentedControl.style { (s) in
            s.insertSegment(withTitle: NSLocalizedString("GroceryItemView.unitSegmentedControl.Title.0", comment: ""), at: 0, animated: false)
            s.insertSegment(withTitle: "100g", at: 1, animated: false)
            s.insertSegment(withTitle: "Kg", at: 2, animated: false)
            s.insertSegment(withTitle: "L", at: 3, animated: false)
            s.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .regular)], for: .normal)
            s.selectedSegmentIndex = 0
            s.addTarget(self, action: #selector(selectedSegmentChanged), for: .valueChanged)
        }
        
        totalTextLabel.style { (s) in
            s.text = NSLocalizedString("GroceryItemView.totalTextLabel.Text", comment: "")
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = .appLabel
        }
        totalValueLabel.style { (s) in
            s.textAlignment = .right
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = .appLabel
        }
        
        addButton.style { (s) in
            let title = NSLocalizedString("GroceryItemView.addButton.Title", comment: "")
            s.setAttributedTitle(NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.white]), for: .normal)
            s.backgroundColor = s.tintColor
            s.layer.cornerRadius = 8
        }
        
        totalNumberFormatter.locale = .current
        totalNumberFormatter.numberStyle = .currency
        totalNumberFormatter.minimumFractionDigits = 2
        totalNumberFormatter.maximumFractionDigits = 2
        updateTotalValue()
    }
}
