//
//  DependencyInjector.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import SwinjectAutoregistration
import Domain
import Common
import AppNavigation

public class DependencyInjector {

    // Properties

    private let launchOptions: LaunchOptions?
    private let window: UIWindow?

    // Initialization

    public init(launchOptions: LaunchOptions?, window: UIWindow?) {
        self.launchOptions = launchOptions
        self.window = window
    }

    // Function

    public func build(completion: (_ assembler: Assembler, _ appCoordinator: AppCoordinator) -> Void) {
        let assembler = Assembler([
            // Assembler Principal
            CoordinatorsFactoryAssembly(),
            ViewControllersFactoryAssembly(),
            CoodinatorAssembly(launchOptions: self.launchOptions, window: self.window),

            // Assembler das features
            FlowAssembly(),

            // Assembler dos frameworks
            DomainAssembly(),
            AppDataAssembly(),
            StorageAssembly(),
            NetworkingAssembly(),
        ])
        let appCoordinator = assembler.resolver.resolveSafe(AppCoordinator.self)
        completion(assembler, appCoordinator)
    }
}
