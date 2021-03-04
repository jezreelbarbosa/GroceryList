//
//  AppCoordinator.swift
//  AppNavigation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit

public protocol AppCoordinatorsFactoryProtocol: DependencyFactory {

    func makeGroceryListCoordinator() -> MainListCoordinator
}

public class AppCoordinator: Coordinator {

    // Properties

    public let navigationController: UINavigationController
    public var childCoordinators: [Coordinator]

    private let launchOptions: LaunchOptions?
    private let window: UIWindow?
    private let coordinatorsFactory: AppCoordinatorsFactoryProtocol

    // Lifecycle 

    public init(with launchOptions: LaunchOptions?, window: UIWindow?, navigationController: UINavigationController,
                coordinatorsFactory: AppCoordinatorsFactoryProtocol) {
        self.launchOptions = launchOptions
        self.window = window
        self.childCoordinators = []
        self.navigationController = navigationController
        self.coordinatorsFactory = coordinatorsFactory
    }

    // Functions

    public func start() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        let coordinator = coordinatorsFactory.makeGroceryListCoordinator()
        childCoordinators = [coordinator]
        coordinator.start()
    }
}

extension AppCoordinator: MainListCoordinatorDelegate {

}
