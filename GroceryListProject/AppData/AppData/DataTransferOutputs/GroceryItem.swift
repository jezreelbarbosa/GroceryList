//
//  GroceryItemDTO.swift
//  AppData
//
//  Created by Jezreel Barbosa on 16/02/21.
//

public struct GroceryItemDTO: Codable {

    let name: String
    let quantity: Decimal
    let unit: Int
    let price: Decimal

    public init(name: String, quantity: Decimal, unit: Int, price: Decimal) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.price = price
    }

    enum CodingKeys: String, CodingKey {
        case name
        case quantity
        case unit
        case price
    }
}
