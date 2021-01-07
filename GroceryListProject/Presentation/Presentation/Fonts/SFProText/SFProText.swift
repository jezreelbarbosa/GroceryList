//
//  SFProText.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit.UIFont

public enum SFProTextFontWeight: CaseIterable {

    private static var isDispachedOnce: Bool = false

    static func registerFonts() {
        if isDispachedOnce { return }
        isDispachedOnce.toggle()
        allCases.forEach { font in
            UIFont.register(path: "", fileNameString: font.name, type: ".otf")
        }
    }

    case regular
    case regularItalic
    case semibold

    var name: String {
        switch self {
            case .regular: return "SFProText-Regular"
            case .regularItalic: return "SFProText-RegularItalic"
            case .semibold: return "SFProText-Semibold"
        }
    }

    var asSystemFontWeight: UIFont.Weight {
        switch self {
            case .regular: return .regular
            case .regularItalic: return .regular
            case .semibold: return .semibold
        }
    }
}
