//
//  GroceryListFooterView.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import Stevia

final class GroceryListFooterView: UITableViewHeaderFooterView {
    // Static properties
    
    static let reuseIdentifier: String = "GroceryListFooterView"
    static let rowHeight: CGFloat = 44.0
    
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        renderSuperView()
        renderLayout()
        renderStyle()
        
        viewModel.listTotalBox.bindAndFire { [weak self] (total) in
            self?.totalLabel.text = total
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private let viewModel = GroceryFooterViewModel()
    
    private let totalLabel = UILabel()
    private let totalNameLabel = UILabel()
    
    // Private Methods
    
    private func renderSuperView() {
        sv(
            totalNameLabel,
            totalLabel
        )
    }
    
    private func renderLayout() {
        totalNameLabel.centerVertically().left(16)
        totalLabel.centerVertically().right(16)
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            
        }
        totalNameLabel.style { (s) in
            s.text = Texts.GroceryListScene.footerTotalLabel.localizedText
            s.textAlignment = .left
            s.textColor = Colors.GroceryListScene.label
        }
        totalLabel.style { (s) in
            s.textAlignment = .right
            s.textColor = Colors.GroceryListScene.label
        }
    }
}
