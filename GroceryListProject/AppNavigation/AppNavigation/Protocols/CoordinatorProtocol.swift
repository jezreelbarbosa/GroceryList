//
//  CoordinatorProtocol.swift
//  AppNavigation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit
import Swinject

public protocol CoordinatorDelegate: class {
    func coordinatorDidExit(_ coordinator: Coordinator)
}

public protocol Coordinator: CoordinatorDelegate {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    public func coordinatorDidExit(_ coordinator: Coordinator) {
        guard let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) else { return }

        self.childCoordinators.remove(at: index)
    }

    public func coordinatorDidExit<T: Coordinator>(_ coordinator: T.Type) {
        debugPrint(childCoordinators)
        guard let index = self.childCoordinators.firstIndex(where: { $0 === coordinator.self }) else { return }
        debugPrint(childCoordinators[index])
        self.childCoordinators.remove(at: index)
    }
}

public protocol TabBarCoordinator: Coordinator {
    var tabBarController: UITabBarController { get }
}

public protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
}
