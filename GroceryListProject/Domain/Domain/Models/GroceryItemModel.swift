//
//  GroceryItemModel.swift
//  Domain
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Foundation

public struct GroceryItemModel {

    public let listID: UUID
    public let id: UUID

    public let name: String
    public let quantity: Decimal
    public let unit: Unit
    public let price: Decimal

    public init(id: UUID, listID: UUID, name: String, quantity: Decimal, unit: Unit, price: Decimal) {
        self.id = id
        self.listID = listID
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.price = price
    }

    public enum Unit: Int {

        case unit = 0
        case kilogram
        case hundredGrams
        case liter
    }
}
