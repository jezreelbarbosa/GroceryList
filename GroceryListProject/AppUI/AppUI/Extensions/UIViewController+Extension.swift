//
//  UIViewController+Extension.swift
//  AppUI
//
//  Created by Jezreel Barbosa on 30/04/21.
//

import UIKit
import ArchitectUtils

public extension UIViewController {

    func presentAttentionAlert(message: String) {
        let title = LocalizedString().enUS("Attention").ptBR("Atenção").localizedText
        let confirmButton = LocalizedString().enUS("Ok").ptBR("Ok").localizedText
        self.presentAlert(title: title, message: message, confirmButton: confirmButton)
    }

    func presentSuccessAlert(message: String) {
        let title = LocalizedString().enUS("Success").ptBR("Sucesso").localizedText
        let confirmButton = LocalizedString().enUS("Ok").ptBR("Ok").localizedText
        self.presentAlert(title: title, message: message, confirmButton: confirmButton)
    }

    func deletingConfirmationAlert(deletingHandler: @escaping () -> Void, defaultHandler: (() -> Void)? = nil) -> UIOptionAlert {
        let title = LocalizedString().enUS("Attention").ptBR("Atenção").localizedText
        let message = LocalizedString()
            .enUS("Are you sure you want to delete this item?")
            .ptBR("Você tem certeza que deseja excluir este item?")
            .localizedText
        let yesTitle = LocalizedString().enUS("Yes").ptBR("Sim").localizedText
        let noTitle = LocalizedString().enUS("No").ptBR("Não").localizedText

        let alert = UIOptionAlert(title: title, message: message, view: self)
        alert.addDestructiveAction(title: yesTitle) { _ in
            deletingHandler()
        }
        alert.addCancelAction(title: noTitle) { _ in
            defaultHandler?()
        }
        return alert
    }
}

public extension UISearchResultsUpdating where Self: UIViewController {

    @discardableResult
    func insertSearchViewController(with placeholder: String? = nil) -> UISearchController {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = placeholder
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        return searchController
    }
}
