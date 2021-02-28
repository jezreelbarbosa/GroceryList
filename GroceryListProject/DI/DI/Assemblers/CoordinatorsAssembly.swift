//
//  CoordinatorAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import AppNavigation

class CoodinatorAssembly {

    let launchOptions: LaunchOptions?
    let window: UIWindow?

    init(launchOptions: LaunchOptions?, window: UIWindow?) {
        self.launchOptions = launchOptions
        self.window = window
    }

    func assembleAppCoordinator(container: Container) {
        let navigationController = UINavigationController()
        let coordinatorsFactory = container.resolveSafe(AppCoordinatorsFactoryProtocol.self)
        container.register(AppCoordinator.self) { _ in
            AppCoordinator(with: self.launchOptions, window: self.window, navigationController: navigationController,
                           coordinatorsFactory: coordinatorsFactory)
        }
    }

    func assembleMainListCoordinator(container: Container) {
        let appCoordinator = container.resolveSafe(AppCoordinator.self)
        let viewControllersFactory = container.resolveSafe(MainListVCFactory.self)
        let coordinatorFactory = container.resolveSafe(MainListCoordinatorFactory.self)
        container.register(MainListCoordinator.self) { _ in
            MainListCoordinator(navigationController: appCoordinator.navigationController, delegate: appCoordinator,
                                viewControllersFactory: viewControllersFactory, coordinatorFactory: coordinatorFactory)
        }
    }

    func assembleGroceryListCoordinator(container: Container) {
        let appCoordinator = container.resolveSafe(AppCoordinator.self)
        let viewControllersFactory = container.resolveSafe(GroceryListVCFactory.self)
        container.register(GroceryListCoordinator.self) { _ in
            GroceryListCoordinator(navigationController: appCoordinator.navigationController,
                                   viewControllersFactory: viewControllersFactory)
        }
    }
}

extension CoodinatorAssembly: Assembly {

    func assemble(container: Container) {
        assembleAppCoordinator(container: container)
        assembleMainListCoordinator(container: container)
        assembleGroceryListCoordinator(container: container)
    }
}
