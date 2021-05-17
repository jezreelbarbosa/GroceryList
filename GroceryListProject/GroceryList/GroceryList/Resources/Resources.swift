//
//  Resources.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 26/02/21.
//

import UIKit
import Presentation

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

        static let itemNavigationTitle = LocalizedString()
            .enUS("Item")
            .ptBR("Item")
            .localizedText

        // - Unit

        static let unitUnit = LocalizedString()
            .enUS("unit")
            .ptBR("unidade")
            .localizedText

        static let unitKilogram = LocalizedString()
            .enUS("Kg")
            .ptBR("Kg")
            .localizedText

        static let unitHundredGrams = LocalizedString()
            .enUS("100g")
            .ptBR("100g")
            .localizedText

        static let unitLiter = LocalizedString()
            .enUS("L")
            .ptBR("L")
            .localizedText

        // - Footer

        static let totalFooterText = LocalizedString()
            .enUS("TOTAL")
            .ptBR("TOTAL")
            .localizedText

        // - Item View

        static let itemNamePlaceholder = LocalizedString()
            .enUS("Item name")
            .ptBR("Nome do item")
            .localizedText

        static let priceText = LocalizedString()
            .enUS("Price:")
            .ptBR("Preço:")
            .localizedText

        static let quantityText = LocalizedString()
            .enUS("Quantity:")
            .ptBR("Quantidade:")
            .localizedText

        static let totalText = LocalizedString()
            .enUS("Total:")
            .ptBR("Total:")
            .localizedText

        // - Error

        static var unknowError = LocalizedString()
            .enUS("Unknow Error! Please, restart the app and try again.")
            .ptBR("Erro desconhecido! Por favor, reinicie o app e tente novamente.")
            .localizedText
    }
}
