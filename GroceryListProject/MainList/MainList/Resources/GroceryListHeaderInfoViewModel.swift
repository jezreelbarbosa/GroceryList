//
//  GroceryListHeaderInfoViewModel.swift
//  MainList
//
//  Created by Jezreel Barbosa on 30/01/21.
//

import Domain

public struct GroceryListHeaderInfoViewModel {

    let uri: URL?

    let icon: String
    let name: String
    let date: String

    init(uri: URL? = nil, icon: String, name: String, date: String) {
        self.uri = uri
        self.icon = icon
        self.name = name
        self.date = date
    }

    init(response: GroceryListModel) {
        self.uri = response.uri
        self.icon = response.icon.isEmpty ? response.name[0..<1] : response.icon
        self.name = response.name

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.date = dateFormatter.string(from: response.date)
    }
}
