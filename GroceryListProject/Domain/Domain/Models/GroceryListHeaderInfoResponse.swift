//
//  GroceryListHeaderInfoResponse.swift
//  Domain
//
//  Created by Jezreel Barbosa on 30/01/21.
//

import Foundation

public struct GroceryListHeaderInfoResponse {

    public let id: UUID

    public let icon: String
    public let name: String
    public let date: Date

    public init(id: UUID, icon: String, name: String, date: Date) {
        self.id = id
        self.icon = icon
        self.name = name
        self.date = date
    }
}
