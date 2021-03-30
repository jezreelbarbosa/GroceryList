//
//  GroceryItemModel.swift
//  Domain
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Foundation

public struct GroceryItemModel {

    public let uri: URL?

    public let name: String
    public let quantity: Decimal
    public let unit: Unit
    public let price: Decimal

    public let date: Date

    public init(uri: URL?, name: String, quantity: Decimal, unit: Unit, price: Decimal, date: Date) {
        self.uri = uri
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.price = price
        self.date = date
    }

    public enum Unit: Int {

        case unit = 0
        case kilogram
        case hundredGrams
        case liter
    }
}
