//
//  GroceryItemDTO.swift
//  AppData
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import Domain

public struct GroceryItemDTO {

    public let uri: URL?

    public let name: String
    public let quantity: Decimal
    public let unit: Int
    public let price: Decimal

    public let date: Date

    public init(uri: URL? = nil, name: String, quantity: Decimal, unit: Int, price: Decimal, date: Date) {
        self.uri = uri
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.price = price
        self.date = date
    }

    init(from domain: GroceryItemModel) {
        self.uri = domain.uri
        self.name = domain.name
        self.quantity = domain.quantity
        self.unit = domain.unit.rawValue
        self.price = domain.price
        self.date = domain.date
    }

    var toDomain: GroceryItemModel {
        GroceryItemModel(uri: uri, name: name, quantity: quantity, unit: GroceryItemModel.Unit(rawValue: unit) ?? .unit, price: price, date: date)
    }
}
