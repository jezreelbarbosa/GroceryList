//
//  ViewControllersFactoryAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import AppNavigation

class ViewControllersFactoryAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MainListVCFactory.self) { ViewControllersFactory(resolver: $0) }
    }
}
