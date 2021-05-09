//
//  MainListCoordinator.swift
//  AppNavigation
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import UIKit
import MainList

public protocol MainListCoordinatorDelegate: CoordinatorDelegate {}

public protocol MainListVCFactory: DependencyFactory {

    func makeMainListViewController() -> MainListViewController
    func makeNewListViewController(uri: URL?, successCompletion: @escaping VoidCompletion) -> NewListViewController
}

public protocol MainListCoordinatorFactory: DependencyFactory {

    func makeGroceryListCoordinator() -> GroceryListCoordinator
}

public class MainListCoordinator: NavigationCoordinator {

    // Properties

    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator]

    weak var delegate: MainListCoordinatorDelegate?
    let viewControllersFactory: MainListVCFactory
    let coordinatorFactory: MainListCoordinatorFactory

    // Lifecycle

    public init(navigationController: UINavigationController, delegate: MainListCoordinatorDelegate,
                viewControllersFactory: MainListVCFactory, coordinatorFactory: MainListCoordinatorFactory) {
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

extension MainListCoordinator: MainListCoordinating {

    public func showNewListView(uri: URL?, successCompletion: @escaping VoidCompletion) {
        let viewController = viewControllersFactory.makeNewListViewController(uri: uri, successCompletion: successCompletion)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalTransitionStyle = .coverVertical
        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController.present(navigationController, animated: true, completion: nil)
    }

    public func showGroceryList(uri: URL) {
        let coordinator = coordinatorFactory.makeGroceryListCoordinator()
        childCoordinators.append(coordinator)
        coordinator.start(uri: uri)
    }

    public func didExit() {
        delegate?.coordinatorDidExit(self)
    }
}

extension MainListCoordinator: GroceryListCoordinatorDelegate {

}
