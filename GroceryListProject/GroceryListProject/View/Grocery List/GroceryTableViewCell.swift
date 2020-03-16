//
//  GroceryTableViewCell.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import UIKit
import Stevia

class GroceryTableViewCell: UITableViewCell {
    // Static properties
    
    static let reuseIdentifier: String = "GroceryTableViewCell"
    static let rowHeight: CGFloat = 64.0
    
    // Public Types
    // Public Properties
    // Public Methods
    
    func fill(_ grocery: Grocery) {
        nameLabel.text = grocery.name
        priceLabel.text = grocery.priceString
        quantityLabel.text = grocery.quantityString
        quantityUnitLabel.text = grocery.unit.shortName
        totalLabel.text = grocery.totalString
        
        self.grocery = grocery
        NotificationCenter.default.addObserver(self, selector: #selector(groceryDidChangeInformation), name: Grocery.valuesDidChangedNN, object: grocery)
    }
    
    // Initialisation/Lifecycle Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    
    override func prepareForReuse() {
        NotificationCenter.default.removeObserver(self)
        nameLabel.text = nil
        priceLabel.text = nil
        quantityLabel.text = nil
        quantityUnitLabel.text = nil
        totalLabel.text = nil
        grocery = nil
    }
    
    // Private Types
    // Private Properties
    
    private weak var grocery: Grocery?
    
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    
    private let separatorLabel = UILabel()
    
    private let quantityLabel = UILabel()
    private let quantityUnitLabel = UILabel()
    
    private let totalLabel = UILabel()
    
    // Private Methods
    
    @objc private func groceryDidChangeInformation() {
        if let grocery = self.grocery {
            nameLabel.text = grocery.name
            priceLabel.text = grocery.priceString
            quantityLabel.text = grocery.quantityString
            quantityUnitLabel.text = grocery.unit.shortName
            totalLabel.text = grocery.totalString
        }
    }
    
    private func renderSuperView() {
        sv(
            nameLabel,
            priceLabel,
            separatorLabel,
            quantityLabel,
            quantityUnitLabel,
            totalLabel
        )
    }
    
    private func renderLayout() {
        nameLabel.top(16).left(16).Right == totalLabel.Left - 8
        
        align(horizontally: priceLabel, separatorLabel, quantityLabel, quantityUnitLabel)
        
        priceLabel.left(16).Top == nameLabel.Bottom + 2
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        priceLabel.Right == separatorLabel.Left - 8
        separatorLabel.Right == quantityLabel.Left - 8
        separatorLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        quantityLabel.Right == quantityUnitLabel.Left
        quantityLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        quantityUnitLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        totalLabel.right(16).centerVertically()
        totalLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.selectionStyle = .none
        }
        nameLabel.style { (s) in
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 17, weight: .semibold)
            s.textColor = .appLabel
        }
        
        priceLabel.style { (s) in
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 14, weight: .light)
            s.textColor = .appLabel
        }
        
        separatorLabel.style { (s) in
            s.text = "•"
            s.textAlignment = .center
            s.font = .systemFont(ofSize: 14, weight: .light)
            s.textColor = .appLabel
        }
        
        quantityLabel.style { (s) in
            s.textAlignment = .right
            s.font = .systemFont(ofSize: 14, weight: .light)
            s.textColor = .appLabel
        }
        quantityUnitLabel.style { (s) in
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 14, weight: .light)
            s.textColor = .appLabel
        }
        
        totalLabel.style { (s) in
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = .appLabel
        }
    }
}
