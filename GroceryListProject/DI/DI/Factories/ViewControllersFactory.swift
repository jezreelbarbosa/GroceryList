//
//  ViewControllersFactory.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Common
import AppNavigation
import MainList

class ViewControllersFactory: DependencyFactory {

    private let resolver: Resolver

    required init(resolver: Resolver) {
        self.resolver = resolver
    }
}

extension ViewControllersFactory: GroceryListVCFactory {

    func makeMainListViewController() -> MainListViewController {
        guard let presenter = resolver.resolve(MainListPresenting.self) as? MainListPresenter else { preconditionFailure() }
        return MainListViewController(presenter: presenter)
    }
}
