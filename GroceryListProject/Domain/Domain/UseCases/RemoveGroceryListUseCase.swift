//
//  RemoveGroceryListUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 21/02/21.
//

import Foundation

public protocol RemoveGroceryListUseCaseProtocol {

    func execute(id: UUID) -> Result<Void, Error>
}

public class RemoveGroceryListUseCase {

    let repository: GroceriesRepository

    public init(repository: GroceriesRepository) {
        self.repository = repository
    }
}

extension RemoveGroceryListUseCase: RemoveGroceryListUseCaseProtocol {

    public func execute(id: UUID) -> Result<Void, Error> {
        repository.removeGroceryList(id: id)
    }
}
