//
//  GroceryListCompleteInfoResponseDTO.swift
//  AppData
//
//  Created by Jezreel Barbosa on 16/02/21.
//

public struct GroceryListCompleteInfoResponseDTO: Codable {

    public let id: UUID

    public let icon: String
    public let name: String
    public let date: Date

    public var items: [GroceryItemDTO]

    public init(id: UUID, icon: String, name: String, date: Date, items: [GroceryItemDTO]) {
        self.id = id
        self.icon = icon
        self.name = name
        self.date = date
        self.items = items
    }

    enum CodingKeys: String, CodingKey {
        case id
        case icon
        case name
        case date
        case items
    }
}
