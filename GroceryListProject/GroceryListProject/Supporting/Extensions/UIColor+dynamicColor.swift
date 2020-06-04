//
//  UIColor+dynamicColor.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 01/06/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
    static func dynamic(any: UIColor, dark: UIColor? = nil) -> UIColor {
        if #available(iOS 13, *) {
            let dynamicColor = UIColor { (uiTraitCollection: UITraitCollection) -> UIColor in
                if uiTraitCollection.userInterfaceStyle == .dark, let dark = dark {
                    return dark
                }
                return any
            }
            return dynamicColor
        }
        return any
    }
}
