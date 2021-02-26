//
//  CreateNewGroceryListUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 16/02/21.
//

public protocol CreateNewGroceryListUseCaseProtocol {

    func execute(request: NewGroceryListRequest) -> Result<Void, Error>
}

public class CreateNewGroceryListUseCase {

    let repository: GroceriesRepository

    public init(repository: GroceriesRepository) {
        self.repository = repository
    }
}

extension CreateNewGroceryListUseCase: CreateNewGroceryListUseCaseProtocol {

    public func execute(request: NewGroceryListRequest) -> Result<Void, Error> {
        repository.saveNewGroceryList(request: request)
    }
}
