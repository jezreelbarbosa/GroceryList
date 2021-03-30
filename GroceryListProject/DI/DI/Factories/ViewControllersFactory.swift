//
//  ViewControllersFactory.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Domain
import AppNavigation
import MainList
import GroceryList

class ViewControllersFactory: DependencyFactory {

    private let resolver: Resolver

    required init(resolver: Resolver) {
        self.resolver = resolver
    }
}

extension ViewControllersFactory: MainListVCFactory {

    func makeMainListViewController() -> MainListViewController {
        guard let presenter = resolver.resolve(MainListPresenting.self) else { preconditionFailure() }
        return MainListViewController(presenter: presenter)
    }

    func makeNewListViewController(successCompletion: @escaping VoidCompletion) -> NewListViewController {
        guard let presenter = resolver.resolve(NewListPresenting.self, argument: successCompletion) else { preconditionFailure() }
        return NewListViewController(presenter: presenter)
    }
}

extension ViewControllersFactory: GroceryListVCFactory {

    func makeGroceryListViewController(uri: URL) -> GroceryListViewController {
        guard let presenter = resolver.resolve(GroceryListPresenting.self, argument: uri) else { preconditionFailure() }
        return GroceryListViewController(presenter: presenter)
    }

    func makeGroceryItemViewController(itemURI: URL?, listURI: URL, successCompletion: @escaping VoidCompletion) -> GroceryItemViewController {
        guard let presenter = resolver.resolve(GroceryItemPresenting.self, arguments: itemURI, listURI, successCompletion)
        else { preconditionFailure() }
        return GroceryItemViewController(presenter: presenter)
    }
}
