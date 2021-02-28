//
//  GroceriesLocalDataSource.swift
//  Storage
//
//  Created by Jezreel Barbosa on 11/02/21.
//

import AppData

public class GroceriesLocalDataSource {

    public let coreData: CoreDataStorage

    public init(coreData: CoreDataStorage) {
        self.coreData = coreData
    }
}

extension GroceriesLocalDataSource: AppData.GroceriesLocalDataSource {

    public func getGroceryMainList() -> Result<[GroceryListCompleteInfoResponseDTO], Error> {
        do {
            let dataArray = try coreData.get(entity: .groceryListEntity).map({ ($0["data"] as? Data).defaultValue })
            let list = try dataArray.map { data in
                try JSONDecoder().decode(GroceryListCompleteInfoResponseDTO.self, from: data)
            }
            return .success(list)
        } catch let error {
            debugPrint(error)
            return .failure(GroceryError.getAllListsError)
        }
    }

    public func saveNewGroceryList(request: GroceryListCompleteInfoResponseDTO) -> Result<Void, Error> {
        do {
            let data = try JSONEncoder().encode(request)
            try coreData.setNew(values: ["data": data], entity: .groceryListEntity, item: ("id", request.id))
            return .success(())
        } catch let error {
            debugPrint(error)
            return .failure(GroceryError.saveNewListError)
        }
    }

    public func removeGroceryList(id: UUID) -> Result<Void, Error> {
        do {
            try coreData.remove(entity: .groceryListEntity, item: ("id", id))
            return .success(())
        } catch let error {
            debugPrint(error)
            return .failure(GroceryError.removeListError)
        }
    }

    public func getGroceryList(id: UUID) -> Result<GroceryListCompleteInfoResponseDTO, Error> {
        do {
            let data = (try coreData.get(entity: .groceryListEntity, item: ("id", id))["data"] as? Data).defaultValue
            let response = try JSONDecoder().decode(GroceryListCompleteInfoResponseDTO.self, from: data)
            return .success(response)
        } catch let error {
            debugPrint(error)
            return .failure(GroceryError.getListError)
        }
    }

    public func update(groceryList: GroceryListUpdatedItemsDTO) -> Result<Void, Error> {
        do {
            let data = (try coreData.get(entity: .groceryListEntity, item: ("id", groceryList.id))["data"] as? Data).defaultValue
            var response = try JSONDecoder().decode(GroceryListCompleteInfoResponseDTO.self, from: data)
            response.items = groceryList.items
            let newData = try JSONEncoder().encode(response)
            try coreData.update(values: ["data": newData], entity: .groceryListEntity, item: ("id", groceryList.id))
            return .success(())
        } catch let error {
            debugPrint(error)
            return .failure(GroceryError.updateListError)
        }
    }
}
