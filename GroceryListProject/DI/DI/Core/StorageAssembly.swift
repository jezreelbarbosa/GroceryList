//
//  StorageAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import AppData
import Storage

class StorageAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CoreDataStorage.self) { _ in CoreDataStorage() }

        container.autoregister(AppData.GroceriesLocalDataSource.self, initializer: Storage.GroceriesLocalDataSource.init)
    }
}
