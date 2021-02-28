//
//  CoordinatorAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import AppNavigation

class CoodinatorAssembly {

    // Properties

    let launchOptions: LaunchOptions?
    let window: UIWindow?

    // Coordinators

    weak var appCoordinator: AppCoordinator?
    weak var mainListCoordinator: MainListCoordinator?
    weak var groceryListCoordinator: GroceryListCoordinator?

    // Lifecycle

    init(launchOptions: LaunchOptions?, window: UIWindow?) {
        self.launchOptions = launchOptions
        self.window = window
    }

    // Assemblers

    func assembleAppCoordinator(container: Container) {
        let navigationController = UINavigationController()
        let coordinatorsFactory = container.resolveSafe(AppCoordinatorsFactoryProtocol.self)

        container.register(AppCoordinator.self) { _ in
            if let coordinator = self.appCoordinator { return coordinator }

            let coordinator = AppCoordinator(with: self.launchOptions, window: self.window,
                                             navigationController: navigationController,
                                             coordinatorsFactory: coordinatorsFactory)
            self.appCoordinator = coordinator
            return coordinator
        }
    }

    func assembleMainListCoordinator(container: Container) {
        let appCoordinator = container.resolveSafe(AppCoordinator.self)
        let viewControllersFactory = container.resolveSafe(MainListVCFactory.self)
        let coordinatorFactory = container.resolveSafe(MainListCoordinatorFactory.self)

        container.register(MainListCoordinator.self) { [weak self] _ in
            if let coordinator = self?.mainListCoordinator { return coordinator }

            let coordinator = MainListCoordinator(navigationController: appCoordinator.navigationController, delegate: appCoordinator,
                                                  viewControllersFactory: viewControllersFactory, coordinatorFactory: coordinatorFactory)
            self?.mainListCoordinator = coordinator
            return coordinator
        }
    }

    func assembleGroceryListCoordinator(container: Container) {
        let mainListCoordinator = container.resolveSafe(MainListCoordinator.self)
        let viewControllersFactory = container.resolveSafe(GroceryListVCFactory.self)

        container.register(GroceryListCoordinator.self) { [weak self] _ in
            if let coordinator = self?.groceryListCoordinator { return coordinator }
            let coordinator = GroceryListCoordinator(navigationController: mainListCoordinator.navigationController,
                                                     delegate: mainListCoordinator, viewControllersFactory: viewControllersFactory)
            self?.groceryListCoordinator = coordinator
            return coordinator
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
