//
//  UIColor+dynamicColor.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit.UIColor

public extension UIColor {

    static func dynamic(any: UIColor, dark: UIColor? = nil) -> UIColor {
        guard #available(iOS 13, *) else {
            return any
        }
        let dynamicColor = UIColor { (uiTraitCollection: UITraitCollection) -> UIColor in
            if uiTraitCollection.userInterfaceStyle == .dark, let dark = dark {
                return dark
            }
            return any
        }
        return dynamicColor
    }
}
