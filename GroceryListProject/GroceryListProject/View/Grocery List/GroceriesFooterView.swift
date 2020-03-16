//
//  GroceriesFooterView.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import UIKit
import Stevia

class GroceriesFooterView: UITableViewHeaderFooterView {
    // Static properties
    
    static let reuseIdentifier: String = "GroceriesFooterView"
    static let rowHeight: CGFloat = 44.0
    
    // Public Types
    // Public Properties
    // Public Methods
    
    func fill(_ total: String) {
        totalLabel.text = total
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateInformation), name: Grocery.listDidUpdateNN, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateInformation), name: Grocery.valuesDidChangedNN, object: nil)
    }
    
    // Initialisation/Lifecycle Methods
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
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
    }
    
    // Private Types
    // Private Properties
    
    private let totalLabel = UILabel()
    private let totalNameLabel = UILabel()
    
    // Private Methods
    
    @objc private func updateInformation() {
        totalLabel.text = Grocery.listTotalString
    }
    
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
            s.text = NSLocalizedString("GroceriesFooterView.totalNameLabel.Text", comment: "")
            s.textAlignment = .left
            s.textColor = .appLabel
        }
        totalLabel.style { (s) in
            s.textAlignment = .right
            s.textColor = .appLabel
        }
    }
}
