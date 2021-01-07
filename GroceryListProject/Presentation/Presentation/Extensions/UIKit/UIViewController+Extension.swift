//
//  UIViewController+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit

public extension UIViewController {

    func presentAlert(withMessage message: String) {
        let alert = UIAlertController.attentionAlert(message: message)
        present(alert, animated: true, completion: nil)
    }
}
