//
//  RemoveGroceryItemUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 29/03/21.
//

public protocol RemoveGroceryItemUseCaseProtocol {

    func execute(uri: URL) -> Result<Void, Error>
}

public class RemoveGroceryItemUseCase {

    let repository: GroceriesRepository

    public init(repository: GroceriesRepository) {
        self.repository = repository
    }
}

extension RemoveGroceryItemUseCase: RemoveGroceryItemUseCaseProtocol {

    public func execute(uri: URL) -> Result<Void, Error> {
        repository.removeGroceryItem(uri: uri)
    }
}
