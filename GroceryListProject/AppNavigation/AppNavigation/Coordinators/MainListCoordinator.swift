//
//  MainListCoordinator.swift
//  AppNavigation
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import UIKit
import MainList

public protocol MainListCoordinatorDelegate: CoordinatorDelegate {

}

public protocol MainListVCFactory: DependencyFactory {

    func makeMainListViewController() -> MainListViewController
    func makeNewListViewController(successCompletion: @escaping VoidCompletion) -> NewListViewController
}

public protocol MainListCoordinatorFactory: DependencyFactory {

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

    public func showNewListView(successCompletion: @escaping VoidCompletion) {
        let viewController = viewControllersFactory.makeNewListViewController(successCompletion: successCompletion)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalTransitionStyle = .coverVertical
        navigationController.modalPresentationStyle = .pageSheet
        self.navigationController.present(navigationController, animated: true, completion: nil)
    }
}
