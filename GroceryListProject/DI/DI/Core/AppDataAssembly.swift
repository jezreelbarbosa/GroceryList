//
//  AppDataAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Domain
import AppData

class AppDataAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(Domain.GroceriesRepository.self, initializer: AppData.GroceriesRepository.init)
    }
}
