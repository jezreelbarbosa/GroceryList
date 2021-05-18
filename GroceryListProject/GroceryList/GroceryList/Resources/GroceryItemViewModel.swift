//
//  GroceryItemViewModel.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Domain

struct GroceryItemViewModel {

    // Models

    private let model: GroceryItemModel

    init(from model: GroceryItemModel) {
        self.model = model
    }

    // Resources

    var uri: URL? {
        model.uri
    }

    var name: String {
        model.name
    }

    var details: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = .current
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 3

        let quantity = numberFormatter.string(for: model.quantity).defaultValue

        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        let price = numberFormatter.string(for: model.price).defaultValue

        let unit: String

        switch model.unit {
        case .unit: unit = Resources.Texts.unitUnit
        case .kilogram: unit = Resources.Texts.unitKilogram
        case .hundredGrams: unit = Resources.Texts.unitHundredGrams
        case .liter: unit = Resources.Texts.unitLiter
        }

        return price + " • " + quantity + " " + unit
    }

    var totalPrice: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = .current
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        return numberFormatter.string(for: totalDecimalPrice).defaultValue
    }

    var totalDecimalPrice: Decimal {
        model.price * model.quantity * ((model.unit == .hundredGrams) ? 10 : 1)
    }
}

extension GroceryItemViewModel: StringSortable {

    var sortString: String {
        name
    }
}
