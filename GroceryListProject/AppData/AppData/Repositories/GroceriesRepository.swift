//
//  GroceriesRepository.swift
//  AppData
//
//  Created by Jezreel Barbosa on 11/02/21.
//

import Domain

public class GroceriesRepository {

    let local: GroceriesLocalDataSource

    public init(local: GroceriesLocalDataSource) {
        self.local = local
    }
}

extension GroceriesRepository: Domain.GroceriesRepository {

    public func getGroceryMainList() -> Result<[GroceryListModel], Error> {
        local.getGroceryMainList().map { newSuccess in
            newSuccess.map({ $0.toDomain })
        }
    }

    public func saveNewGroceryList(request: NewGroceryListRequest) -> Result<Void, Error> {
        let requestDTO = GroceryListDTO(from: request)
        return local.saveNewGroceryList(request: requestDTO)
    }

    public func removeGroceryList(uri: URL) -> Result<Void, Error> {
        local.removeGroceryList(uri: uri)
    }

    public func getGroceryList(uri: URL) -> Result<GroceryListModel, Error> {
        local.getGroceryList(uri: uri).map({ $0.toDomain })
    }

    public func getGroceryItem(uri: URL) -> Result<GroceryItemModel, Error> {
        local.getGroceryItem(uri: uri).map({ $0.toDomain })
    }

    public func addOrUpdate(groceryItem: GroceryItemModel, into listURI: URL) -> Result<Void, Error> {
        let requestDTO = GroceryItemDTO(from: groceryItem)
        return local.addOrUpdate(groceryItem: requestDTO, into: listURI)
    }

    public func removeGroceryItem(uri: URL) -> Result<Void, Error> {
        local.removeGroceryItem(uri: uri)
    }
}
