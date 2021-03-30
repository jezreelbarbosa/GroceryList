//
//  Font.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit.UIFont

public final class Font {

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

    public static func sfProDisplay(_ weight: SFProDisplayFontWeight, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: weight.name, size: size) else {
            return UIFont.systemFont(ofSize: size, weight: weight.asSystemFontWeight)
        }
        return font
    }

    // MARK: - Configuration

    static func register(path: String, fileNameString: String, type: String) {
        let frameworkBundle = Bundle(for: Font.self)

        guard let resourceBundleURL = frameworkBundle.path(forResource: path + "/" + fileNameString, ofType: type),
              let fontData = NSData(contentsOfFile: resourceBundleURL), let dataProvider = CGDataProvider(data: fontData),
              let fontRef = CGFont(dataProvider),
              CTFontManagerRegisterGraphicsFont(fontRef, nil)
        else {
            debugPrint("Font Error")
            return
        }
    }

    public static func registerFonts() {
        NewYorkLargeFontWeight.registerFonts()
        SFProTextFontWeight.registerFonts()
        SFProDisplayFontWeight.registerFonts()
    }
}
