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
    
    static let valuesDidChangedNN = Notification.Name("com.jezreelbarbosa.GroceryCalculator.Grocery.valuesDidChangedNN")
    static let listDidUpdateNN = Notification.Name("com.jezreelbarbosa.GroceryCalculator.Grocery.listDidUpdateNN")
    static let listAddedNewItemNN = Notification.Name("com.jezreelbarbosa.GroceryCalculator.Grocery.listAddedNewItemNN")
    
    static var list: [Grocery] = [] {
        didSet {
            NotificationCenter.default.post(name: Grocery.listDidUpdateNN, object: nil)
            if Grocery.list.count > oldValue.count {
                NotificationCenter.default.post(name: Grocery.listAddedNewItemNN, object: nil)
            }
        }
    }
    
    static var listTotalString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = .current
        numberFormatter.numberStyle = .currency
        
        var totalDecimal: Decimal = 0
        Grocery.list.forEach({ totalDecimal += $0.total })
        return numberFormatter.string(for: totalDecimal) ?? ""
    }
    
    // Static Methods
    // Public Types
    
    enum UnitOfMeasurement: Int {
        case unit = 0
        case g100
        case kg
        case l
        
        static let allCases: [Grocery.UnitOfMeasurement] = [
            .unit,
            .g100,
            .kg,
            .l
        ]
        
        private static let allShortNames: [Grocery.UnitOfMeasurement: String] = [
            .unit: " un",
            .g100: "Kg / 100g",
            .kg: "Kg",
            .l: "L"
        ]
        
        var shortName: String {
            return Grocery.UnitOfMeasurement.allShortNames[self] ?? ""
        }
    }
    
    // Public Properties
    
    private(set) var name: String
    private(set) var price: Decimal
    private(set) var quantity: Decimal
    private(set) var unit: UnitOfMeasurement
    
    var total: Decimal {
        let factor: Decimal = (unit == .g100) ? 0.1 : 1
        return price * quantity / factor
    }
    
    var priceString: String {
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(for: price) ?? ""
    }
    
    var quantityString: String {
        switch unit {
        case .unit:
            numberFormatter.numberStyle = .none
            numberFormatter.maximumFractionDigits = 0
            numberFormatter.minimumFractionDigits = 0
            
        case .kg, .l, .g100:
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 3
            numberFormatter.minimumFractionDigits = 3
        }
        return numberFormatter.string(for: quantity) ?? ""
    }
    
    var totalString: String {
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(for: total) ?? ""
    }
    
    // Public Methods
    
    func setValues(_ name: String, price: Decimal, quantity: Decimal, unit: UnitOfMeasurement) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.unit = unit
        NotificationCenter.default.post(name: Grocery.valuesDidChangedNN, object: self)
    }
    
    // Initialisation/Lifecycle Methods
    
    init(_ name: String, price: Decimal, quantity: Decimal, unit: UnitOfMeasurement) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.unit = unit
        numberFormatter.locale = .current
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private let numberFormatter = NumberFormatter()
    
    // Private Methods
}
