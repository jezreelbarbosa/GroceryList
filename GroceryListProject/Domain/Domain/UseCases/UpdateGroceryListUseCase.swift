//
//  UpdateGroceryListUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 28/02/21.
//

public protocol UpdateGroceryItemUseCaseProtocol {

    func execute(model: GroceryItemModel) -> Result<Void, Error>
}

public class UpdateGroceryItemUseCase {

    let repository: GroceriesRepository

    public init(repository: GroceriesRepository) {
        self.repository = repository
    }
}

extension UpdateGroceryItemUseCase: UpdateGroceryItemUseCaseProtocol {

    public func execute(model: GroceryItemModel) -> Result<Void, Error> {
        
        return .success(())
    }
}
