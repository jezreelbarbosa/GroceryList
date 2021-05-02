//
//  UIContextualAction+Extension.swift
//  AppUI
//
//  Created by Jezreel Barbosa on 26/04/21.
//

import UIKit
import Presentation

public extension UIContextualAction {

    static func deleteAction(_ completion: @escaping () -> Void) -> UIContextualAction {
        let image = AppUIAssets.Icons.trash.image?.withRenderingMode(.alwaysOriginal)
        return UIContextualAction(.destructive, image: image, title: nil) { _, _, handler in
            completion()
            handler(true)
        }
    }

    static func deleteConfirmationAction(view: UIViewController, _ completion: @escaping () -> Void) -> UIContextualAction {
        let image = AppUIAssets.Icons.trash.image?.withRenderingMode(.alwaysOriginal)
        return UIContextualAction(.destructive, image: image, title: nil) { _, _, handler in
            view.deletingConfirmationAlert(deletingHandler: {
                completion()
                handler(true)
            }, defaultHandler: {
                handler(false)
            }).present()
        }
    }

    static func editAction(_ completion: @escaping () -> Void) -> UIContextualAction {
        let image = AppUIAssets.Icons.pencil.image?.withRenderingMode(.alwaysOriginal)
        return UIContextualAction(image: image, title: nil) { _, _, handler in
            completion()
            handler(true)
        }
    }
}
