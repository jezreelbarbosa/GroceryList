//
//  SFProDisplay.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 30/01/21.
//

import UIKit.UIFont

public enum SFProDisplayFontWeight: CaseIterable {

    private static var isDispachedOnce: Bool = false

    static func registerFonts() {
        if isDispachedOnce { return }
        isDispachedOnce.toggle()
        allCases.forEach { font in
            UIFont.register(path: "", fileNameString: font.name, type: ".otf")
        }
    }

    case regular
    case semibold
    case light
    case thin

    var name: String {
        switch self {
        case .regular: return "SFProDisplay-Regular"
        case .semibold: return "SFProDisplay-Semibold"
        case .light: return "SFProDisplay-Light"
        case .thin: return "SFProDisplay-Thin"
        }
    }

    var asSystemFontWeight: UIFont.Weight {
        switch self {
        case .regular: return .regular
        case .semibold: return .semibold
        case .light: return .light
        case .thin: return .thin
        }
    }
}
