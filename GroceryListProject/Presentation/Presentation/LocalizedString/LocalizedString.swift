//
//  LocalizedString.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

public enum Language: String {

    case enUS = "en_US"
    case ptBR = "pt_BR"
    case frEU = "fr_EU"
}

public class LocalizedString {

    // Properties

    private let texts: [Language: String]
    private var defaultText: String { texts[.enUS] ?? "" }

    public var localizedText: String {
        switch NSLocalizedString("Localized", bundle: Bundle(for: LocalizedString.self), comment: "") {
        case Language.ptBR.rawValue: return texts[.ptBR] ?? defaultText
        case Language.enUS.rawValue: return texts[.enUS] ?? defaultText
        case Language.frEU.rawValue: return texts[.frEU] ?? defaultText
        default: return defaultText
        }
    }

    // Lifecycle

    public init(texts: [Language: String]) {
        self.texts = texts
    }
}
