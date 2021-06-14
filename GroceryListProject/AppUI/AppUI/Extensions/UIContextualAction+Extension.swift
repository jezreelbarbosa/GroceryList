//
//  UIContextualAction+Extension.swift
//  AppUI
//
//  Created by Jezreel Barbosa on 26/04/21.
//

import UIKit
import ArchitectUtils

public extension UIContextualAction {

    static func deleteAction(_ completion: @escaping () -> Void) -> UIContextualAction {
        let image = Assets.Icons.trash.image?.original
        return UIContextualAction(.destructive, image: image, title: nil) { _, _, handler in
            completion()
            handler(true)
        }
    }

    static func deleteConfirmationAction(view: UIViewController, _ completion: @escaping () -> Void) -> UIContextualAction {
        let image = Assets.Icons.trash.image?.original
        return UIContextualAction(.destructive, image: image, title: nil) { _, _, handler in
            view.deletingConfirmationAlert(deletingHandler: {
                completion()
                handler(true)
            }, defaultHandler: {
                handler(false)
            }).present()
        }
    }

    static func editAction(_ completion: @escaping VoidCompletion) -> UIContextualAction {
        let image = Assets.Icons.pencil.image?.original
        return UIContextualAction(image: image, title: nil) { _, _, handler in
            completion()
            handler(true)
        }
    }

    static func checkAction(isChecked: Bool, _ completion: @escaping VoidCompletion) -> UIContextualAction {
        let checkmark = Assets.Icons.checkmark.image?.original
        let xmark = Assets.Icons.xmark.image?.original
        let action = UIContextualAction(image: isChecked ? xmark : checkmark, title: nil) { _, _, handler in
            completion()
            handler(true)
        }
        action.backgroundColor = .systemGreen
        return action
    }
}

public extension Equatable {

    @discardableResult
    func doOn(_ value: Self, _ handler: () -> Void) -> Self {
        if self == value {
            handler()
        }
        return self
    }
}
