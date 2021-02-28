//
//  GroceryItemViewModel.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Domain

struct GroceryItemViewModel {

    let name: String
    let details: String
    let totalPrice: String

    let totalDecimalPrice: Decimal

    init(from model: GroceryItemModel) {
        self.name = model.name

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

        self.details = price + " • " + quantity + " " + unit
        self.totalDecimalPrice = model.price * model.quantity
        self.totalPrice = numberFormatter.string(for: totalDecimalPrice).defaultValue
    }
}
