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
        let title = LocalizedString().enUS("Delete").ptBR("Apagar").localizedText
        return UIContextualAction(.destructive, image: image, title: title) { _, _, handler in
            completion()
            handler(true)
        }
    }

    static func editAction(_ completion: @escaping () -> Void) -> UIContextualAction {
        let image = AppUIAssets.Icons.pencil.image?.withRenderingMode(.alwaysOriginal)
        let title = LocalizedString().enUS("Edit").ptBR("Editar").localizedText
        return UIContextualAction(image: image, title: title) { _, _, handler in
            completion()
            handler(true)
        }
    }
}
