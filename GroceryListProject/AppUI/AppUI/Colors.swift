//
//  Colors.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit.UIColor

/// Palette 🎨
public final class Palette {

    /// White ⬜️
    public struct White {
        /// #FFFFFF
        public static var white: UIColor { #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) }
        /// #EFEFF4
        public static var ghostWhite: UIColor { #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1) }
        /// #EBEBF5
        public static var magnolia: UIColor { #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9607843137, alpha: 1) }
        /// #EBEBF5 60%
        public static var magnolia60: UIColor { magnolia.withAlphaComponent(0.60) }
    }

    /// Gray  🌫
    public struct Gray {
        /// #3C3C43
        public static var jet: UIColor { #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 1) }
        /// #3C3C43 29%
        public static var jet29: UIColor { jet.withAlphaComponent(0.29) }
        /// #3C3C43 60%
        public static var jet60: UIColor { jet.withAlphaComponent(0.60) }
        /// #545458
        public static var devisGrey: UIColor { #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3450980392, alpha: 1) }
        /// #545458 65%
        public static var devisGrey65: UIColor { devisGrey.withAlphaComponent(0.65) }
    }

    /// Black ⬛️
    public struct Black {
        /// #000000
        public static var black: UIColor { #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) }
        /// #1C1C1E
        public static var eerieBlack: UIColor { #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1176470588, alpha: 1) }
    }

    /// Red 🟥
    public struct Red {
        /// #BB2825
        public static var fireBrick: UIColor { #colorLiteral(red: 0.7333333333, green: 0.1568627451, blue: 0.1450980392, alpha: 1) }
    }

    /// Green 🟩
    public struct Green {
        /// #7C8452
        public static var mossGreen: UIColor { #colorLiteral(red: 0.4862745098, green: 0.5176470588, blue: 0.3215686275, alpha: 1) }
    }

    /// Blue 🟦
    public struct Blue {
        /// #33658A
        public static var lapisLazule: UIColor { #colorLiteral(red: 0.2, green: 0.3960784314, blue: 0.5411764706, alpha: 1) }
    }

    /// Yellow 🟨
    public struct Yellow {

    }

    /// Orange 🟧
    public struct Orange {

    }

    /// Purple 🟪
    public struct Purple {

    }

    /// Brown 🟫
    public struct Brown {
        /// #885F24
        public static var brown: UIColor { #colorLiteral(red: 0.5333333333, green: 0.3725490196, blue: 0.1411764706, alpha: 1) }
        /// #6B430A
        public static var sepia: UIColor { #colorLiteral(red: 0.4196078431, green: 0.262745098, blue: 0.03921568627, alpha: 1) }
        /// #A18251
        public static var matallicSunburst: UIColor { #colorLiteral(red: 0.631372549, green: 0.5098039216, blue: 0.3176470588, alpha: 1) }
    }

    /// Texture 📜
    public struct Texture {

    }
}
