//
//  GroceryFooterViewModel.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 08/06/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import Foundation

final class GroceryFooterViewModel {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    let listTotalBox: Box<String> = Box("")
    
    // Public Methods
    
    @objc func updateValues() {
        listTotalBox.value = listTotal
    }
    
    // Initialisation/Lifecycle Methods
    
    init() {
        numberFormatter.locale = .current
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .currency
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateValues), name: Grocery.valuesDidChangedNN, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private let numberFormatter = NumberFormatter()
    
    private var listTotal: String {
        var totalDecimal: Decimal = 0
        Grocery.list.forEach { (grocery) in
            let factor: Decimal = (grocery.unit == .g100) ? 0.1 : 1
            let subTotal = grocery.price * grocery.quantity / factor
            totalDecimal += subTotal
        }
        return numberFormatter.string(for: totalDecimal) ?? ""
    }
    
    // Private Methods
}
