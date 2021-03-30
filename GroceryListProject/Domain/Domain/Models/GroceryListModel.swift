//
//  GroceryListModel.swift
//  Domain
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Foundation

public struct GroceryListModel {

    public let uri: URL?

    public let icon: String
    public let name: String
    public let date: Date

    public let items: [GroceryItemModel]

    public init(uri: URL?, icon: String, name: String, date: Date, items: [GroceryItemModel]) {
        self.uri = uri
        self.icon = icon
        self.name = name
        self.date = date
        self.items = items
    }
}
