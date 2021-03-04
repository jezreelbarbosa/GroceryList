//
//  GroceryListViewModel.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Domain

public struct GroceryListViewModel {

    static var empty: GroceryListViewModel {
        GroceryListViewModel(from: GroceryListModel(id: UUID(), name: .defaultValue, items: .defaultValue))
    }

    let listName: String
    let items: [GroceryItemViewModel]

    init(from model: GroceryListModel) {
        self.listName = model.name
        self.items = model.items.map({ GroceryItemViewModel(from: $0) })
    }

    var totalPrice: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = .current
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        let total = items.reduce(0, { $0 + $1.totalDecimalPrice })
        return numberFormatter.string(for: total).defaultValue
    }
}
