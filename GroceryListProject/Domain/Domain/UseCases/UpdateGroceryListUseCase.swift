//
//  UpdateGroceryListUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 21/04/21.
//

public protocol UpdateGroceryListUseCaseProtocol {

    func execute(request: GroceryListModel) -> Result<Void, Error>
}

public class UpdateGroceryListUseCase {

    let repository: GroceriesRepository

    public init(repository: GroceriesRepository) {
        self.repository = repository
    }
}

extension UpdateGroceryListUseCase: UpdateGroceryListUseCaseProtocol {

    public func execute(request: GroceryListModel) -> Result<Void, Error> {
        repository.addOrUpdate(groceryList: request)
    }
}
