//
//  UIAlertController+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit

public extension UIAlertController {

    static func alert(title: String, message: String, confirmButton: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirmButton, style: .default, handler: nil))
        return alert
    }
}
