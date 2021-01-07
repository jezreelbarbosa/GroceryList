//
//  LocalizedString.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 30/06/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import Foundation

enum Language {
    case enUS
    case ptBR
}

struct LocalizedString {
    private let texts: [Language: String]

    init(texts: [Language: String]) {
        self.texts = texts
    }

    init(singleText: String) {
        self.texts = [.enUS: singleText]
    }

    var localizedText: String {
        switch Locale.current.identifier {
        case "en_US": return texts[.enUS] ?? ""
        case "pt_BR": return texts[.ptBR] ?? ""
        default: return texts[.enUS] ?? ""
        }
    }
}
