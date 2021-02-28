//
//  GroceryListCoordinator.swift
//  AppNavigation
//
//  Created by Jezreel Barbosa on 15/01/21.
//

import UIKit
import GroceryList

public protocol GroceryListCoordinatorDelegate: CoordinatorDelegate {}

public protocol GroceryListVCFactory: DependencyFactory {

    func makeGroceryListViewController(id: UUID) -> GroceryListViewController
}

public class GroceryListCoordinator: NavigationCoordinator {

    // Properties

    weak var delegate: GroceryListCoordinatorDelegate?

    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator]

    let viewControllersFactory: GroceryListVCFactory

    // Lifecycle

    public init(navigationController: UINavigationController, viewControllersFactory: GroceryListVCFactory) {
        self.navigationController = navigationController
        self.viewControllersFactory = viewControllersFactory
        self.childCoordinators = []
    }

    // Functions

    public func start(id: UUID) {
        let viewController = viewControllersFactory.makeGroceryListViewController(id: id)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension GroceryListCoordinator: GroceryListCoordinating {

    public func showItemView(successCompletion: @escaping VoidCompletion) {
        // TODO: Implement Item View
    }

    public func didExit() {
        delegate?.coordinatorDidExit(self)
    }
}
