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
    }

    struct Texts {

        static let homeNavigationTitle = LocalizedString(texts: [
            .enUS: "Home",
            .ptBR: "Início"
        ]).localizedText

        static let newListNavigationTitle = LocalizedString(texts: [
            .enUS: "New list",
            .ptBR: "Nova lista"
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
            .enUS: "100g / Kg",
            .ptBR: "100g / Kg"
        ]).localizedText

        static let unitLiter = LocalizedString(texts: [
            .enUS: "L",
            .ptBR: "L"
        ]).localizedText

        // -

        static let totalFooterText = LocalizedString(texts: [
            .enUS: "TOTAL",
            .ptBR: "TOTAL"
        ]).localizedText
    }
}
