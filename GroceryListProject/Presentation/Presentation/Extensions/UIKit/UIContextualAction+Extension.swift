//
//  UIContextualAction+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 13/04/21.
//

import UIKit

public extension UIContextualAction {

    enum UIStyle {

        case image
        case text
    }

    static func deleteAction(style: UIStyle, handler: @escaping UIContextualAction.Handler) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .destructive, title: nil, handler: handler)
        switch style {
        case .image:
            deleteAction.image = Assets.System.trash.image
        case .text:
            deleteAction.title = Texts.deleteAction.localizedText
        }
        return deleteAction
    }

    static func editAction(style: UIStyle, handler: @escaping UIContextualAction.Handler) -> UIContextualAction {
        let editAction = UIContextualAction(style: .normal, title: nil, handler: handler)
        switch style {
        case .image:
            editAction.image = Assets.System.pencil.image
        case .text:
            editAction.title = Texts.editAction.localizedText
        }
        return editAction
    }
}
