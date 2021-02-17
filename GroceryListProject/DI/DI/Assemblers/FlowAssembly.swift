//
//  FlowAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Domain
import AppNavigation
import MainList

class FlowAssembly {

    private func assembleMainList(container: Container) {
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
}

extension FlowAssembly: Assembly {

    func assemble(container: Container) {
        assembleMainList(container: container)
    }
}
