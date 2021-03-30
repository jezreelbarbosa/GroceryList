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

    func makeGroceryListViewController(uri: URL) -> GroceryListViewController
    func makeGroceryItemViewController(itemURI: URL?, listURI: URL, successCompletion: @escaping VoidCompletion) -> GroceryItemViewController
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

    public func start() {
        preconditionFailure("Must use start(uri:)")
    }

    public func start(uri: URL) {
        let viewController = viewControllersFactory.makeGroceryListViewController(uri: uri)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension GroceryListCoordinator: GroceryListCoordinating {
    public func showItemView(itemURI: URL?, listURI: URL, successCompletion: @escaping VoidCompletion) {
        let viewController = viewControllersFactory.makeGroceryItemViewController(itemURI: itemURI, listURI: listURI,
                                                                                  successCompletion: successCompletion)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalTransitionStyle = .coverVertical
        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController.present(navigationController, animated: true, completion: nil)
    }

    public func didExit() {
        delegate?.coordinatorDidExit(self)
    }
}
