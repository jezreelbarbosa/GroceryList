//
//  CoordinatorsFactory.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Common
import AppNavigation

class CoordinatorsFactory: DependencyFactory {

    private let resolver: Resolver

    required init(resolver: Resolver) {
        self.resolver = resolver
    }
}

extension CoordinatorsFactory: AppCoordinatorsFactoryProtocol {

    func makeGroceryListCoordinator() -> GroceryListCoordinator {
        resolver.resolveSafe(GroceryListCoordinator.self)
    }
}

extension CoordinatorsFactory: GroceryListCoordinatorFactory {

}
