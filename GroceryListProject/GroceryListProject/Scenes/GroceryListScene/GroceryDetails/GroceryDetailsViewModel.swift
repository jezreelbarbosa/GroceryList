//
//  GroceryDetailsViewModel.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 05/06/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import Foundation

final class GroceryDetailsViewModel {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    weak var grocery: Grocery? = nil {
        didSet {
            NotificationCenter.default.removeObserver(self)
            guard grocery != nil else { return }
            NotificationCenter.default.addObserver(self, selector: #selector(updateValues), name: Grocery.valuesDidChangedNN, object: grocery)
            updateValues()
        }
    }
    
    let totalBox: Box<String> = Box("")
    
    var name: String {
        return grocery?.name ?? ""
    }
    
    var price: String {
        guard let grocery = grocery, grocery.price != 0 else { return "" }
        
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(for: grocery.price) ?? ""
    }
    
    var quantity: String {
        guard let grocery = grocery, grocery.quantity != 0 else { return "" }
        
        switch grocery.unit {
        case .unit:
            numberFormatter.numberStyle = .none
            numberFormatter.maximumFractionDigits = 0
            numberFormatter.minimumFractionDigits = 0
            
        case .kg, .l, .g100:
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 3
            numberFormatter.minimumFractionDigits = 3
        }
        return numberFormatter.string(for: grocery.quantity) ?? ""
    }
    
    var total: String {
        guard let grocery = grocery else { return "" }
        
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .currency
        
        let factor: Decimal = (grocery.unit == .g100) ? 0.1 : 1
        let total = grocery.price * grocery.quantity / factor
        
        return numberFormatter.string(for: total) ?? ""
    }
    
    var unit: Grocery.UnitOfMeasurement {
        return grocery?.unit ?? .unit
    }
    
    // Public Methods
    
    @objc func updateValues() {
        totalBox.value = total
    }
    
    // Initialisation/Lifecycle Methods
    
    init() {
        numberFormatter.locale = .current
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private let numberFormatter = NumberFormatter()
    
    // Private Methods
}
