//
//  GetGroceryListUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 28/02/21.
//

public protocol GetGroceryListUseCaseProtocol {

    func execute(uri: URL) -> Result<GroceryListModel, Error>
}

public class GetGroceryListUseCase {

    let repository: GroceriesRepository

    public init(repository: GroceriesRepository) {
        self.repository = repository
    }
}

extension GetGroceryListUseCase: GetGroceryListUseCaseProtocol {

    public func execute(uri: URL) -> Result<GroceryListModel, Error> {
        repository.getGroceryList(uri: uri)
    }
}
