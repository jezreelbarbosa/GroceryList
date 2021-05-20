//
//  UINavigationController+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit

public extension UINavigationController {

    enum Style {

        case transparent
        case opaque
    }

    func set(style: Style) {
        switch style {
        case .transparent:
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .opaque:
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.shadowImage = nil
        }
    }
}
