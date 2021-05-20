//
//  Resources.swift
//  MainList
//
//  Created by Jezreel Barbosa on 15/01/21.
//

import UIKit
import ArchitectUtils

class Resources {

    struct Colors {

        static let textColor = UIColor.dynamic(any: Palette.Black.black, dark: Palette.White.white)

        static let modalBackgroundColor = UIColor.dynamic(any: Palette.White.white, dark: Palette.Black.eerieBlack)

        static let tableBackgroundColor = UIColor.dynamic(any: Palette.White.ghostWhite, dark: Palette.Black.black)
        static let cellBackgroundColor = UIColor.dynamic(any: Palette.White.white, dark: Palette.Black.eerieBlack)
        static let cellSeparatorColor = UIColor.dynamic(any: Palette.Gray.jet29, dark: Palette.Gray.devisGrey65)
    }

    struct Texts {

        static let searchPlaceholder = LocalizedString()
            .enUS("Search list")
            .ptBR("Procurar list")
            .localizedText

        static let homeNavigationTitle = LocalizedString()
            .enUS("Home")
            .ptBR("Início")
            .localizedText

        static let newListNavigationTitle = LocalizedString()
            .enUS("New list")
            .ptBR("Nova lista")
            .localizedText

        static let editListNavigationTitle = LocalizedString()
            .enUS("Edit list")
            .ptBR("Editar lista")
            .localizedText

        static let newListNameText = LocalizedString()
            .enUS("Grocery List")
            .ptBR("Lista de Compras")
            .localizedText

        static let newListIconText = LocalizedString()
            .enUS("🛒")
            .ptBR("🛒")
            .localizedText

        static var unknowError = LocalizedString()
            .enUS("Unknow Error! Please, restart the app and try again.")
            .ptBR("Erro desconhecido! Por favor, reinicie o app e tente novamente.")
            .localizedText
    }
}
