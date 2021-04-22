//
//  DomainAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Domain

class DomainAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(GetGroceryMainListUseCaseProtocol.self, initializer: GetGroceryMainListUseCase.init)
        container.autoregister(CreateNewGroceryListUseCaseProtocol.self, initializer: CreateNewGroceryListUseCase.init)
        container.autoregister(UpdateGroceryListUseCaseProtocol.self, initializer: UpdateGroceryListUseCase.init)
        container.autoregister(RemoveGroceryListUseCaseProtocol.self, initializer: RemoveGroceryListUseCase.init)
        container.autoregister(GetGroceryListUseCaseProtocol.self, initializer: GetGroceryListUseCase.init)
        container.autoregister(GetGroceryItemUseCaseProtocol.self, initializer: GetGroceryItemUseCase.init)
        container.autoregister(InsertGroceryItemIntoListUseCaseProtocol.self, initializer: InsertGroceryItemIntoListUseCase.init)
        container.autoregister(RemoveGroceryItemUseCaseProtocol.self, initializer: RemoveGroceryItemUseCase.init)
    }
}
