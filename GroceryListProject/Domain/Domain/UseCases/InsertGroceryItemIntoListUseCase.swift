//
//  InsertGroceryItemIntoListUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 01/03/21.
//

public protocol InsertGroceryItemIntoListUseCaseProtocol {

    func execute(model: GroceryItemModel) -> Result<Void, Error>
}

public class InsertGroceryItemIntoListUseCase {

    let repository: GroceriesRepository

    public init(repository: GroceriesRepository) {
        self.repository = repository
    }
}

extension InsertGroceryItemIntoListUseCase: InsertGroceryItemIntoListUseCaseProtocol {

    public func execute(model: GroceryItemModel) -> Result<Void, Error> {
        repository.updateGroceryItem(model: model)
    }
}
