//
//  Resources.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 26/02/21.
//

import UIKit

class Resources {

    struct Colors {

        static let textColor = UIColor.dynamic(any: Palette.Black.black, dark: Palette.White.white)

        static let modalBackgroundColor = UIColor.dynamic(any: Palette.White.white, dark: Palette.Black.eerieBlack)

        static let tableBackgroundColor = UIColor.dynamic(any: Palette.White.white, dark: Palette.Black.black)
        static let cellBackgroundColor = UIColor.dynamic(any: Palette.White.white, dark: Palette.Black.black)
        static let footerBackgroundColor = UIColor.dynamic(any: Palette.White.ghostWhite, dark: Palette.Black.eerieBlack)

        static let separatorColor = UIColor.dynamic(any: Palette.Gray.jet.withAlphaComponent(0.29),
                                                    dark: Palette.Gray.devisGrey.withAlphaComponent(0.65))
    }

    struct Texts {

        // - Navigation

        static let itemNavigationTitle = LocalizedString(texts: [
            .enUS: "Item",
            .ptBR: "Item"
        ]).localizedText

        // - Unit

        static let unitUnit = LocalizedString(texts: [
            .enUS: "unit",
            .ptBR: "unidade"
        ]).localizedText

        static let unitKilogram = LocalizedString(texts: [
            .enUS: "Kg",
            .ptBR: "Kg"
        ]).localizedText

        static let unitHundredGrams = LocalizedString(texts: [
            .enUS: "Kg / 100g",
            .ptBR: "Kg / 100g"
        ]).localizedText

        static let unitLiter = LocalizedString(texts: [
            .enUS: "L",
            .ptBR: "L"
        ]).localizedText

        // - Footer

        static let totalFooterText = LocalizedString(texts: [
            .enUS: "TOTAL",
            .ptBR: "TOTAL"
        ]).localizedText

        // - Item View

        static let itemNamePlaceholder = LocalizedString(texts: [
            .enUS: "Item name",
            .ptBR: "Nome do item"
        ]).localizedText

        static let priceText = LocalizedString(texts: [
            .enUS: "Price:",
            .ptBR: "Preço:"
        ]).localizedText

        static let quantityText = LocalizedString(texts: [
            .enUS: "Quantity:",
            .ptBR: "Quantidade:"
        ]).localizedText

        static let totalText = LocalizedString(texts: [
            .enUS: "Total:",
            .ptBR: "Total:"
        ]).localizedText
    }
}
