//
//  NewYorkLarge.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit.UIFont

public enum NewYorkLargeFontWeight: CaseIterable {
    
    private static var isDispachedOnce: Bool = false

    static func registerFonts() {
        if isDispachedOnce { return }
        isDispachedOnce.toggle()
        allCases.forEach { font in
            Font.register(path: "", fileNameString: font.name, type: ".otf")
        }
    }

    case regular
    case semibold

    var name: String {
        switch self {
        case .regular: return "NewYorkLarge-Regular"
        case .semibold: return "NewYorkLarge-Semibold"
        }
    }

    var asSystemFontWeight: UIFont.Weight {
        switch self {
        case .regular: return .regular
        case .semibold: return .semibold
        }
    }
}
