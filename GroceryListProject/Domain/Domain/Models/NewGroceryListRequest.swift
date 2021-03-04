//
//  NewGroceryListRequest.swift
//  Domain
//
//  Created by Jezreel Barbosa on 16/02/21.
//

public struct NewGroceryListRequest {

    public let icon: String
    public let name: String
    public let date: Date

    public init(icon: String, name: String, date: Date) {
        self.icon = icon
        self.name = name
        self.date = date
    }
}
