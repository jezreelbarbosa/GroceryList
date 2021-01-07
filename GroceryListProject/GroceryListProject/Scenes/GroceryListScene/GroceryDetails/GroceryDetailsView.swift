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
    
    let priceTextLabel = UILabel()
    let quantityTextLabel = UILabel()
    
    let totalTextLabel = UILabel()
    let totalValueLabel = UILabel()
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    // Private Methods
    
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
        
        priceDecimalField.setContentCompressionResistancePriority(.required, for: .horizontal)
        priceDecimalField.setContentCompressionResistancePriority(.required, for: .vertical)
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
            s.backgroundColor = Colors.GroceryListScene.background
        }
        groceryNameTextField.style { (s) in
            s.placeholder = Texts.GroceryListScene.groceryNameTextFieldPlaceholder.localizedText
            s.borderStyle = .roundedRect
            s.textAlignment = .left
            s.returnKeyType = .next
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = Colors.GroceryListScene.label
        }
        
        priceTextLabel.style { (s) in
            s.text = Texts.GroceryListScene.priceTextLabel.localizedText
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = Colors.GroceryListScene.label
        }
        priceDecimalField.style { (s) in
            s.numberFormatter.minimumFractionDigits = 2
            s.numberFormatter.maximumFractionDigits = 2
            s.numberFormatter.numberStyle = .currency
            s.returnKeyType = .next
            s.borderStyle = .roundedRect
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = Colors.GroceryListScene.label
        }
        
        quantityTextLabel.style { (s) in
            s.text = Texts.GroceryListScene.quantityTextLabel.localizedText
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = Colors.GroceryListScene.label
        }
        quantityDecimalField.style { (s) in
            s.numberFormatter.minimumFractionDigits = 0
            s.numberFormatter.maximumFractionDigits = 0
            s.numberFormatter.numberStyle = .decimal
            s.returnKeyType = .done
            s.borderStyle = .roundedRect
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = Colors.GroceryListScene.label
            s.text = "1"
        }
        
        unitSegmentedControl.style { (s) in
            s.insertSegment(withTitle: Texts.GroceryListScene.unitSegmetedControl_Title0.localizedText, at: 0, animated: false)
            s.insertSegment(withTitle: "100g", at: 1, animated: false)
            s.insertSegment(withTitle: "Kg", at: 2, animated: false)
            s.insertSegment(withTitle: "L", at: 3, animated: false)
            s.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .regular)], for: .normal)
            s.selectedSegmentIndex = 0
        }
        
        totalTextLabel.style { (s) in
            s.text = Texts.GroceryListScene.itemTotalLabel.localizedText
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = Colors.GroceryListScene.label
        }
        totalValueLabel.style { (s) in
            s.textAlignment = .right
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = Colors.GroceryListScene.label
        }
        
        addButton.style { (s) in
            let title = Texts.GroceryListScene.addButton.localizedText
            s.setAttributedTitle(NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.white]), for: .normal)
            s.backgroundColor = s.tintColor
            s.layer.cornerRadius = 8
        }
    }
}
