//
//  UpdateGroceryListUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 28/02/21.
//

public protocol UpdateGroceryListUseCaseProtocol {

    func execute(model: GroceryListModel) -> Result<Void, Error>
}

public class UpdateGroceryListUseCase {

    let repository: GroceriesRepository

    public init(repository: GroceriesRepository) {
        self.repository = repository
    }
}

extension UpdateGroceryListUseCase: UpdateGroceryListUseCaseProtocol {

    public func execute(model: GroceryListModel) -> Result<Void, Error> {
        repository.updateGroceryList(model: model)
    }
}
