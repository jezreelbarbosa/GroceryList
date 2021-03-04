//
//  GroceryListModel.swift
//  Domain
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Foundation

public struct GroceryListModel {

    public let id: UUID
    public let name: String
    public let items: [GroceryItemModel]

    public init(id: UUID, name: String, items: [GroceryItemModel]) {
        self.id = id
        self.name = name
        self.items = items
    }
}
