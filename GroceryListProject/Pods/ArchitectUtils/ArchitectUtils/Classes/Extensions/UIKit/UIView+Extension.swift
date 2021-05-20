//
//  UIView+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit

public extension UIView {

    func setTapToEndEditing() {
        let tapToHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(endEditingForced))
        addGestureRecognizer(tapToHideKeyboard)
    }

    @objc private func endEditingForced() {
        endEditing(true)
    }

    func makeCircleBorders() {
        layer.cornerRadius = min(bounds.width, bounds.height) / 2.0
        layer.masksToBounds = true
    }
}
