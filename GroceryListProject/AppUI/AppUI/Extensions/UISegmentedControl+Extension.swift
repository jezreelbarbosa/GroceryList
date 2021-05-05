//
//  UISegmentedControl+Extension.swift
//  AppUI
//
//  Created by Jezreel Barbosa on 05/05/21.
//

import UIKit

public extension UISegmentedControl {

    var font: UIFont? {
        get {
            titleTextAttributes(for: .normal)?[.font] as? UIFont
        }
        set {
            setTitleTextAttributes([.font: newValue as Any], for: .normal)
            let name = UIContentSizeCategory.didChangeNotification
            NotificationCenter.default.removeObserver(self, name: name, object: nil)

            if newValue == nil { return }
            NotificationCenter.default.addObserver(self, selector: #selector(update), name: name, object: nil)
        }
    }

    @objc private func update() {
        setTitleTextAttributes([.font: font as Any], for: .normal)
    }
}
