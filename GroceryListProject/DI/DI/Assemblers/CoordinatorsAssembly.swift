//
//  CoordinatorAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Common
import AppNavigation

class CoodinatorAssembly {

    private let launchOptions: LaunchOptions?
    private let window: UIWindow?

    init(launchOptions: LaunchOptions?, window: UIWindow?) {
        self.launchOptions = launchOptions
        self.window = window
    }

    private func assembleAppCoordinator(container: Container) {
        let navigationController = UINavigationController()
        let coordinatorsFactory = container.resolveSafe(AppCoordinatorsFactoryProtocol.self)
        container.register(AppCoordinator.self) { _ in
            AppCoordinator(with: self.launchOptions, window: self.window, navigationController: navigationController,
                           coordinatorsFactory: coordinatorsFactory)
        }
    }

    private func assembleGroceryCoordinator(container: Container) {
        let appCoordinator = container.resolveSafe(AppCoordinator.self)
        let viewControllersFactory = container.resolveSafe(GroceryListVCFactory.self)
        let coordinatorFactory = container.resolveSafe(GroceryListCoordinatorFactory.self)
        container.register(GroceryListCoordinator.self) { _ in
            GroceryListCoordinator(navigationController: appCoordinator.navigationController, delegate: appCoordinator,
                                   viewControllersFactory: viewControllersFactory, coordinatorFactory: coordinatorFactory)
        }
    }
}

extension CoodinatorAssembly: Assembly {

    func assemble(container: Container) {
        assembleAppCoordinator(container: container)
        assembleGroceryCoordinator(container: container)
    }
}
