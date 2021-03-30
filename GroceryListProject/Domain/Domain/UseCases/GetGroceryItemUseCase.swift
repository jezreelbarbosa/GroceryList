//
//  GetGroceryItemUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 29/03/21.
//

public protocol GetGroceryItemUseCaseProtocol {

    func execute(uri: URL) -> Result<GroceryItemModel, Error>
}

public class GetGroceryItemUseCase {

    let repository: GroceriesRepository

    public init(repository: GroceriesRepository) {
        self.repository = repository
    }
}

extension GetGroceryItemUseCase: GetGroceryItemUseCaseProtocol {

    public func execute(uri: URL) -> Result<GroceryItemModel, Error> {
        repository.getGroceryItem(uri: uri)
    }
}
