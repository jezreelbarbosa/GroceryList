//
//  LocalizedString.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

public protocol StringText {

    var text: String { get }
}

public enum Language: String {

    case enUS = "en_US"
    case ptBR = "pt_BR"
}

public class LocalizedString {

    // Properties

    public var localizedText: String {
        switch NSLocalizedString("Localized", bundle: Bundle(for: LocalizedString.self), comment: "") {
        case Language.ptBR.rawValue: return texts[.ptBR] ?? defaultText
        case Language.enUS.rawValue: return texts[.enUS] ?? defaultText
        default: return defaultText
        }
    }

    private let texts: [Language: String]
    private var defaultText: String { texts[.enUS] ?? "" }

    // Lifecycle

    public init(texts: [Language: String]) {
        self.texts = texts
    }
}
