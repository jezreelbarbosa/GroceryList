//
//  Font.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit

public protocol FontRegistrable: RawRepresentable {

    static var familyName: String { get }
    static var useOnlyRawValueName: Bool { get }
    static var bundle: Bundle { get }

    var name: String { get }
    var fileType: String { get }
    var asSystemFontWeight: UIFont.Weight { get }
    var pointsByScreenSize: CGFloat { get }

    func maximumPointsToIncreaseSize(for style: UIFont.TextStyle) -> CGFloat
    func fontSize(for style: UIFont.TextStyle) -> CGFloat
    func fixedFont(size: CGFloat, tryToRegister: Bool) -> UIFont
    func font(_ style: UIFont.TextStyle, size: CGFloat?) -> UIFont
}

public extension FontRegistrable where RawValue == String {

    static var useOnlyRawValueName: Bool {
        return false
    }

    static var bundle: Bundle {
        .main
    }

    var name: String {
        Self.useOnlyRawValueName ? rawValue : Self.familyName + "-" + rawValue.capitalizingFirstLetter()
    }

    var fileType: String {
        "otf"
    }

    var asSystemFontWeight: UIFont.Weight {
        .regular
    }

    var pointsByScreenSize: CGFloat {
        switch UIScreen.main.bounds.width {
        case ...320: return 0
        case ...390: return 1
        case ...428: return 3
        default: return 4
        }
    }

    func maximumPointsToIncreaseSize(for style: UIFont.TextStyle) -> CGFloat {
        return .greatestFiniteMagnitude
    }

    func fontSize(for style: UIFont.TextStyle) -> CGFloat {
        switch style {
        case .largeTitle: return 34
        case .title1: return 28
        case .title2: return 22
        case .title3: return 20
        case .headline: return 17
        case .body: return 17
        case .callout: return 16
        case .subheadline: return 15
        case .footnote: return 13
        case .caption1: return 12
        case .caption2: return 11
        default: return 17
        }
    }

    func fixedFont(size: CGFloat, tryToRegister: Bool = true) -> UIFont {
        if let font = UIFont(name: name, size: size) {
            return font
        }
        if tryToRegister {
            Self.register(fileNameString: name, type: fileType, bundle: Self.bundle)
            return fixedFont(size: size, tryToRegister: false)
        }
        debugPrint("Warning: \(name) font not registered.")
        return .systemFont(ofSize: size, weight: asSystemFontWeight)
    }

    func font(_ style: UIFont.TextStyle = .body, size: CGFloat? = nil) -> UIFont {
        let fontScreenSize = (size ?? fontSize(for: style)) + pointsByScreenSize
        let maximumPointSize = fontScreenSize + maximumPointsToIncreaseSize(for: style)
        return style.metrics.scaledFont(for: fixedFont(size: fontScreenSize), maximumPointSize: maximumPointSize)
    }
}

private extension FontRegistrable where RawValue == String  {

    static func register(fileNameString: String, type: String, bundle: Bundle) {
        guard let resourceBundleURL = bundle.url(forResource: fileNameString, withExtension: type),
              let dataProvider = CGDataProvider(url: resourceBundleURL as CFURL),
              let fontRef = CGFont(dataProvider),
              CTFontManagerRegisterGraphicsFont(fontRef, nil)
        else {
            debugPrint("Register font error: \(fileNameString).\(type) at \(bundle)")
            return
        }
    }
}
