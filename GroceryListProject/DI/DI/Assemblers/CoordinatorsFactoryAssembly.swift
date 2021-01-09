//
//  CoordinatorsFactoryAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import AppNavigation

class CoordinatorsFactoryAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AppCoordinatorsFactoryProtocol.self) { CoordinatorsFactory(resolver: $0) }
        container.register(GroceryListCoordinatorFactory.self) { CoordinatorsFactory(resolver: $0) }
    }
}
