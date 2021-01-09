//
//  LocalizedString.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Foundation

public protocol StringText {

    var text: String { get }
}

public enum Language: String {

    case enUS = "en_US"
    case ptBR = "pt_BR"
}

public struct LocalizedString {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties

    public var localizedText: String {
        switch NSLocalizedString("Localized", comment: "") {
        case Language.ptBR.rawValue: return texts[.ptBR] ?? defaultText
        case Language.enUS.rawValue: return texts[.enUS] ?? defaultText
        default: return defaultText
        }
    }

    // Public Methods
    // Initialization/Lifecycle Methods

    public init(texts: [Language: String]) {
        self.texts = texts
    }

    // Override Methods
    // Private Types
    // Private Properties

    private let texts: [Language: String]

    private var defaultText: String { texts[.enUS] ?? "" }

    // Private Methods
}
