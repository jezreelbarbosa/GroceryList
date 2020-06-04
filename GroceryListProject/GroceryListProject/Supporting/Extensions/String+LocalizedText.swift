//
//  String+LocalizedText.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 01/06/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
