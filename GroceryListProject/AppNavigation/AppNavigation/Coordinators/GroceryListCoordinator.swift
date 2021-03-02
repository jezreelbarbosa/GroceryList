//
//  GroceryListCoordinator.swift
//  AppNavigation
//
//  Created by Jezreel Barbosa on 15/01/21.
//

import UIKit
import Domain
import GroceryList

public protocol GroceryListCoordinatorDelegate: CoordinatorDelegate {}

public protocol GroceryListVCFactory: DependencyFactory {

    func makeGroceryListViewController(id: UUID) -> GroceryListViewController
    func makeGroceryItemViewController(item: GroceryItemModel, successCompletion: @escaping VoidCompletion) -> GroceryItemViewController
}

public class GroceryListCoordinator: NavigationCoordinator {

    // Properties

    weak var delegate: GroceryListCoordinatorDelegate?

    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator]

    let viewControllersFactory: GroceryListVCFactory

    // Lifecycle

    public init(navigationController: UINavigationController,
                delegate: GroceryListCoordinatorDelegate?,
                viewControllersFactory: GroceryListVCFactory) {
        self.navigationController = navigationController
        self.delegate = delegate
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

    public func showItemView(item: GroceryItemModel, successCompletion: @escaping VoidCompletion) {
        let viewController = viewControllersFactory.makeGroceryItemViewController(item: item, successCompletion: successCompletion)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalTransitionStyle = .coverVertical
        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController.present(navigationController, animated: true, completion: nil)
    }

    public func didExit() {
        delegate?.coordinatorDidExit(self)
    }
}
