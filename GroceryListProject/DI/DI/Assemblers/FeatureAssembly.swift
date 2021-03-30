//
//  FeatureAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Domain
import AppNavigation
import MainList
import GroceryList

class FeatureAssembly {

    func assembleMainList(container: Container) {
        let coordinator = container.resolveSafe(MainListCoordinator.self)
        container.register(MainListCoordinating.self) { _ in coordinator }

        container.autoregister(MainListPresenting.self, initializer: MainListPresenter.init)
        container.register(NewListPresenting.self) { (resolver: Resolver, successCompletion: @escaping VoidCompletion) in
            NewListPresenter(
                createNewGroceryListUseCase: resolver.resolveSafe(CreateNewGroceryListUseCaseProtocol.self),
                successCompletion: successCompletion
            )
        }
    }

    func assembleGroceryList(container: Container) {
        let coordinator = container.resolveSafe(GroceryListCoordinator.self)
        container.register(GroceryListCoordinating.self) { _ in coordinator }

        container.register(GroceryListPresenting.self) { (resolver: Resolver, uri: URL) in
            GroceryListPresenter(
                groceryListURI: uri, coordinator: coordinator,
                getGroceryListUseCase: resolver.resolveSafe(GetGroceryListUseCaseProtocol.self),
                removeGroceryItemUseCase: resolver.resolveSafe(RemoveGroceryItemUseCaseProtocol.self)
            )
        }
        container.register(GroceryItemPresenting.self) { (resolver: Resolver, uri: URL?, listURI: URL, successCompletion: @escaping VoidCompletion) in
            GroceryItemPresenter(
                insertGroceryItemIntoListUseCase: resolver.resolveSafe(InsertGroceryItemIntoListUseCaseProtocol.self),
                getGroceryItemUseCase: resolver.resolveSafe(GetGroceryItemUseCaseProtocol.self),
                itemURI: uri, listURI: listURI, successCompletion: successCompletion
            )
        }
    }
}

extension FeatureAssembly: Assembly {

    func assemble(container: Container) {
        assembleMainList(container: container)
        assembleGroceryList(container: container)
    }
}
