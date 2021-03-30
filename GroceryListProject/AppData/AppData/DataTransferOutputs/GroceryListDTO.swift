//
//  GroceryListCompleteInfoResponseDTO.swift
//  AppData
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import Domain

public struct GroceryListDTO {

    public let uri: URL?

    public let icon: String
    public let name: String
    public let date: Date

    public var items: [GroceryItemDTO]

    public init(uri: URL? = nil, icon: String, name: String, date: Date, items: [GroceryItemDTO] = []) {
        self.uri = uri
        self.icon = icon
        self.name = name
        self.date = date
        self.items = items
    }

    public init(from domain: NewGroceryListRequest) {
        self.uri = nil
        self.icon = domain.icon
        self.name = domain.name
        self.date = domain.date
        self.items = []
    }

    var toDomain: GroceryListModel {
        GroceryListModel(uri: uri, icon: icon, name: name, date: date, items: items.map({ $0.toDomain }))
    }
}
