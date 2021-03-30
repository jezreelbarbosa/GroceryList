//
//  InsertGroceryItemIntoListUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 01/03/21.
//

public protocol InsertGroceryItemIntoListUseCaseProtocol {

    func execute(model: GroceryItemModel, listURI: URL) -> Result<Void, Error>
}

public class InsertGroceryItemIntoListUseCase {

    let repository: GroceriesRepository

    public init(repository: GroceriesRepository) {
        self.repository = repository
    }
}

extension InsertGroceryItemIntoListUseCase: InsertGroceryItemIntoListUseCaseProtocol {

    public func execute(model: GroceryItemModel, listURI: URL) -> Result<Void, Error> {
        repository.addOrUpdate(groceryItem: model, into: listURI)
    }
}
