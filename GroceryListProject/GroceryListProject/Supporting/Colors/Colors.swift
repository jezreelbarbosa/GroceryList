//
//  Colors.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import UIKit.UIColor

/// Colors 🎨
final class Colors {
    private init() {}
    
    // MARK: - Grocery List Scene
    struct GroceryListScene {
        /// white ⬜️ - black ⬛️
        static let background = UIColor.dynamic(any: Palette.White.white, dark: Palette.Black.black)
        /// black ⬛️ - white ⬜️
        static let label = UIColor.dynamic(any: Palette.Black.black, dark: Palette.White.white)
    }
}
