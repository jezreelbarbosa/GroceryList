//
//  GroceryListViewModel.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Domain

public struct GroceryListViewModel {

    // Models

    static var empty: GroceryListViewModel {
        GroceryListViewModel(from: GroceryListModel(uri: nil, icon: .defaultValue, name: .defaultValue, date: Date(), items: .defaultValue))
    }

    private let model: GroceryListModel

    init(from model: GroceryListModel) {
        self.model = model
    }

    // Resources

    var listName: String {
        return model.name
    }

    var items: [GroceryItemViewModel] {
        return model.items.map({ GroceryItemViewModel(from: $0) })
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
