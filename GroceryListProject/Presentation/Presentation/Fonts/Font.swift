//
//  Font.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit.UIFont

public final class Font {

    public static func registerFonts() {
        SFProTextFontWeight.registerFonts()
        NewYorkLargeFontWeight.registerFonts()
    }

    public static func newYorkLarge(_ weight: NewYorkLargeFontWeight, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: weight.name, size: size) else {
            return UIFont.systemFont(ofSize: size, weight: weight.asSystemFontWeight)
        }
        return font
    }

    public static func sfProText(_ weight: SFProTextFontWeight, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: weight.name, size: size) else {
            return UIFont.systemFont(ofSize: size, weight: weight.asSystemFontWeight)
        }
        return font
    }
}
