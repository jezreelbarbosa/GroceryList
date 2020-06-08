//
//  GroceryTableViewCell.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import Stevia

final class GroceryTableViewCell: UITableViewCell {
    // Static properties
    
    static let reuseIdentifier: String = "GroceryTableViewCell"
    static let rowHeight: CGFloat = 64.0
    
    // Public Types
    // Public Properties
    // Public Methods
    
    func fill(_ grocery: Grocery) {
        viewModel.grocery = grocery
        
        viewModel.updateValues()
    }
    
    // Initialisation/Lifecycle Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        renderSuperView()
        renderLayout()
        renderStyle()
        
        viewModel.nameBox.bindAndFire { [weak self] (name) in
            self?.nameLabel.text = name
        }
        viewModel.priceBox.bindAndFire { [weak self] (price) in
            self?.priceLabel.text = price
        }
        viewModel.quantityBox.bindAndFire { [weak self] (quantity) in
            self?.quantityLabel.text = quantity
        }
        viewModel.unitBox.bindAndFire { [weak self] (unit) in
            self?.quantityUnitLabel.text = unit
        }
        viewModel.totalBox.bindAndFire { [weak self] (total) in
            self?.totalLabel.text = total
        }
    }
    
    required init?(coder: NSCoder) {
       fatalError()
    }
    
    // Override Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel.grocery = nil
        
        nameLabel.text = nil
        priceLabel.text = nil
        quantityLabel.text = nil
        quantityUnitLabel.text = nil
        totalLabel.text = nil
    }
    
    // Private Types
    // Private Properties
    
    private let viewModel = GroceryCellViewModel()
    
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    
    private let separatorLabel = UILabel()
    
    private let quantityLabel = UILabel()
    private let quantityUnitLabel = UILabel()
    
    private let totalLabel = UILabel()
    
    // Private Methods
    
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
            s.textColor = Colors.GroceryListScene.label
        }
        
        priceLabel.style { (s) in
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 14, weight: .light)
            s.textColor = Colors.GroceryListScene.label
        }
        
        separatorLabel.style { (s) in
            s.text = "•"
            s.textAlignment = .center
            s.font = .systemFont(ofSize: 14, weight: .light)
            s.textColor = Colors.GroceryListScene.label
        }
        
        quantityLabel.style { (s) in
            s.textAlignment = .right
            s.font = .systemFont(ofSize: 14, weight: .light)
            s.textColor = Colors.GroceryListScene.label
        }
        quantityUnitLabel.style { (s) in
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 14, weight: .light)
            s.textColor = Colors.GroceryListScene.label
        }
        
        totalLabel.style { (s) in
            s.textAlignment = .left
            s.font = .systemFont(ofSize: 17, weight: .regular)
            s.textColor = Colors.GroceryListScene.label
        }
    }
}
