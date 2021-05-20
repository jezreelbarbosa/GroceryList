//
//  UIContextualAction+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 11/04/21.
//

import UIKit

public extension UIContextualAction {

    convenience init(_ style: UIContextualAction.Style = .normal, image: UIImage? = nil, title: String? = nil,
                     handler: @escaping UIContextualAction.Handler) {
        self.init(style: style, title: title, handler: handler)
        self.image = image
    }
}
