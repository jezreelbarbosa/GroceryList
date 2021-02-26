//
//  GroceryItemDTO.swift
//  AppData
//
//  Created by Jezreel Barbosa on 16/02/21.
//

public struct GroceryItemDTO: Codable {

    let name: String
    let unit: Int
    let price: Decimal

    public init(name: String, unit: Int, price: Decimal) {
        self.name = name
        self.unit = unit
        self.price = price
    }

    enum CodingKeys: String, CodingKey {
        case name
        case unit
        case price
    }
}
