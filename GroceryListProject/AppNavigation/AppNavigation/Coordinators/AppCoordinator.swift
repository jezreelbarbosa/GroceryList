//
//  AppCoordinator.swift
//  AppNavigation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit
import Common

public protocol AppCoordinatorsFactoryProtocol: DependencyFactory {

}

public class AppCoordinator: Coordinator {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties

    public let navigationController: UINavigationController
    public var childCoordinators: [Coordinator]

    // Public Methods

    public func start() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    // Initialization/Lifecycle Methods

    public init(with launchOptions: LaunchOptions?, window: UIWindow?, navigationController: UINavigationController,
                coordinatorsFactory: AppCoordinatorsFactoryProtocol) {
        self.launchOptions = launchOptions
        self.window = window
        self.childCoordinators = []
        self.navigationController = navigationController
        self.coordinatorsFactory = coordinatorsFactory
    }

    // Override Methods
    // Private Types
    // Private Properties

    private let launchOptions: LaunchOptions?
    private let window: UIWindow?
    private let coordinatorsFactory: AppCoordinatorsFactoryProtocol

    // Private Methods
}
