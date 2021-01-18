//
//  Resources.swift
//  MainList
//
//  Created by Jezreel Barbosa on 15/01/21.
//

import UIKit
import Presentation

class Resources {

    struct Colors {

        static let backgroundColor = UIColor.dynamic(any: Palette.White.white, dark: Palette.Black.black)
        static let foregroundColor = UIColor.dynamic(any: Palette.Black.black, dark: Palette.White.white)
    }

    struct Texts {

        static let navigationTitle = LocalizedString(texts: [
            .enUS: "Sheets",
            .ptBR: "Fichas"
        ]).localizedText

        static let sheetsPlaceholder = LocalizedString(texts: [
            .enUS: "You haven't created any character sheets yet. :( Go ahead!",
            .ptBR: "Você ainda não criou nenhuma ficha de personagem. :( Vá em frente!"
        ]).localizedText
    }
}
