//
//  UIViewController+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit

public extension UIViewController {

    func presentAlert(title: String, message: String, confirmButton: String) {
        let alert = UIAlertController.alert(title: title, message: message, confirmButton: confirmButton)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
