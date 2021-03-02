//
//  GroceryItemUpdateRequest.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 01/03/21.
//

import Domain

public struct GroceryItemUpdateRequest {

    static var empty: GroceryItemUpdateRequest {
        GroceryItemUpdateRequest(itemName: "", price: 0, unit: 0, quantity: 0)
    }

    static func from(domain: GroceryItemModel) -> GroceryItemUpdateRequest {
        GroceryItemUpdateRequest(itemName: domain.name, price: domain.price, unit: domain.unit.rawValue, quantity: domain.quantity)
    }

    let itemName: String
    let price: Decimal
    let unit: Int
    let quantity: Decimal
}
