//
//  Grocery.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import Foundation

class Grocery {
    // Static Properties
    
    static let valuesDidChangedNN = Notification.Name("com.jezreelbarbosa.listinha.Grocery.valuesDidChangedNN")
    static let listDidUpdateNN = Notification.Name("com.jezreelbarbosa.listinha.Grocery.listDidUpdateNN")
    static let listAddedNewItemNN = Notification.Name("com.jezreelbarbosa.listinha.Grocery.listAddedNewItemNN")
    
    static var list: [Grocery] = [] {
        didSet {
            NotificationCenter.default.post(name: Grocery.listDidUpdateNN, object: nil)
            if Grocery.list.count > oldValue.count {
                NotificationCenter.default.post(name: Grocery.listAddedNewItemNN, object: nil)
            }
        }
    }
    
    // Static Methods
    // Public Types
    
    enum UnitOfMeasurement: Int {
        case unit = 0
        case g100
        case kg
        case l
    }
    
    // Public Properties
    
    private(set) var name: String
    private(set) var price: Decimal
    private(set) var quantity: Decimal
    private(set) var unit: UnitOfMeasurement
    
    
    // Public Methods
    
    func setValues(_ name: String, price: Decimal, quantity: Decimal, unit: UnitOfMeasurement) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.unit = unit
        NotificationCenter.default.post(name: Grocery.valuesDidChangedNN, object: self)
    }
    
    // Initialisation/Lifecycle Methods
    
    convenience init() {
        self.init("", price: 0, quantity: 1, unit: .unit)
    }
    
    init(_ name: String, price: Decimal, quantity: Decimal, unit: UnitOfMeasurement) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.unit = unit
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    // Private Methods
}
