//
//  GroceryListUpdatedItemsDTO.swift
//  AppData
//
//  Created by Jezreel Barbosa on 28/02/21.
//

import Domain

public struct GroceryListUpdatedItemsDTO {

    public let id: UUID
    public var items: [GroceryItemDTO]

    public init(from domain: GroceryListModel) {
        self.id = domain.id
        self.items = domain.items.map({ GroceryItemDTO(from: $0) })
    }
}
