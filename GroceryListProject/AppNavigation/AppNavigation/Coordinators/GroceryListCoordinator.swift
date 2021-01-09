//
//  GroceryListCoordinator.swift
//  AppNavigation
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import UIKit
import Common
import MainList

public protocol GroceryListCoordinatorDelegate: CoordinatorDelegate {

}

public protocol GroceryListVCFactory: DependencyFactory {

    func makeMainListViewController() -> MainListViewController
}

public protocol GroceryListCoordinatorFactory: DependencyFactory {

}

public class GroceryListCoordinator: NavigationCoordinator {

    // Properties
    
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator]

    weak var delegate: GroceryListCoordinatorDelegate?
    let viewControllersFactory: GroceryListVCFactory
    let coordinatorFactory: GroceryListCoordinatorFactory

    // Lifecycle

    public init(navigationController: UINavigationController, delegate: GroceryListCoordinatorDelegate,
                viewControllersFactory: GroceryListVCFactory, coordinatorFactory: GroceryListCoordinatorFactory) {
        self.navigationController = navigationController
        self.delegate = delegate
        self.viewControllersFactory = viewControllersFactory
        self.coordinatorFactory = coordinatorFactory
        self.childCoordinators = []
    }

    // Functions

    public func start() {
        let viewController = viewControllersFactory.makeMainListViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension GroceryListCoordinator: MainListCoordinating {

}
