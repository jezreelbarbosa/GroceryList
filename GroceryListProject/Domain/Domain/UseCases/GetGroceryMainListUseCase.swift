//
//  GetGroceryMainListUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 11/02/21.
//

import Foundation

public protocol GetGroceryMainListUseCaseProtocol {

    func execute() -> Result<[GroceryListHeaderInfoResponse], Error>
}

public class GetGroceryMainListUseCase {

    let repository: GroceriesRepository

    public init(repository: GroceriesRepository) {
        self.repository = repository
    }
}

extension GetGroceryMainListUseCase: GetGroceryMainListUseCaseProtocol {

    public func execute() -> Result<[GroceryListHeaderInfoResponse], Error> {
        repository.getGroceryMainList()
    }
}
