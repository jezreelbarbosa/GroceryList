//
//  FlowAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Common
import AppNavigation
import MainList

class FlowAssembly {

    private func assembleMainList(container: Container) {
        let coordinator = container.resolveSafe(MainListCoordinator.self)
        container.register(MainListCoordinating.self) { _ in coordinator }
        container.autoregister(MainListPresenting.self, initializer: MainListPresenter.init)
        container.autoregister(NewListPresenting.self, initializer: NewListPresenter.init)
    }
}

extension FlowAssembly: Assembly {

    func assemble(container: Container) {
        assembleMainList(container: container)
    }
}
