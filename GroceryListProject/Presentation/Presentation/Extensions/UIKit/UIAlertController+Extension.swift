//
//  UIAlertController+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit

public extension UIAlertController {

    static func attentionAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: Texts.attentionTitle.localizedText, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Texts.okButton.localizedText, style: .default, handler: nil))
        return alert
    }
}
