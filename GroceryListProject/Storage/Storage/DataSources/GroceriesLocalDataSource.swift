//
//  GroceriesLocalDataSource.swift
//  Storage
//
//  Created by Jezreel Barbosa on 11/02/21.
//

import AppData
import CoreData

public class GroceriesLocalDataSource {

    public let coreData: CoreDataStorage

    public init(coreData: CoreDataStorage) {
        self.coreData = coreData
    }
}

extension GroceriesLocalDataSource: AppData.GroceriesLocalDataSource {

    public func getGroceryMainList() -> Result<[GroceryListDTO], Error> {
        do {
            let list = try coreData.getEntity(GroceryListEntity.self).map({ $0.toDTO })
            return .success(list)
        } catch let error {
            debugPrint(error)
            return .failure(GroceryError.getAllListsError)
        }
    }

    public func saveNewGroceryList(request: GroceryListDTO) -> Result<Void, Error> {
        do {
            let entity = try coreData.newEntity(GroceryListEntity.self)
            entity.update(icon: request.icon, name: request.name, date: request.date, items: [])
            try coreData.insert(object: entity)
            return .success(())
        } catch let error {
            debugPrint(error)
            return .failure(GroceryError.saveNewListError)
        }
    }

    public func removeGroceryList(uri: URL) -> Result<Void, Error> {
        do {
            try coreData.remove(itemAt: uri)
            return .success(())
        } catch let error {
            debugPrint(error)
            return .failure(GroceryError.getAllListsError)
        }
    }

    public func getGroceryList(uri: URL) -> Result<GroceryListDTO, Error> {
        do {
            let listDTO = try coreData.getEntity(GroceryListEntity.self, at: uri).toDTO
            return .success(listDTO)
        } catch let error {
            debugPrint(error)
            return .failure(GroceryError.getAllListsError)
        }
    }

    public func getGroceryItem(uri: URL) -> Result<GroceryItemDTO, Error> {
        do {
            let itemDTO = try coreData.getEntity(GroceryItemEntity.self, at: uri).toDTO
            return .success(itemDTO)
        } catch let error {
            debugPrint(error)
            return .failure(GroceryError.getAllListsError)
        }
    }

    public func addOrUpdate(groceryItem: GroceryItemDTO, into listURI: URL) -> Result<Void, Error> {
        do {
            let itemEntity: GroceryItemEntity
            if let itemURI = groceryItem.uri {
                itemEntity = try coreData.getEntity(GroceryItemEntity.self, at: itemURI)
            } else {
                itemEntity = try coreData.newEntity(GroceryItemEntity.self)

                try coreData.insert(object: itemEntity)
                let listEntity = try coreData.getEntity(GroceryListEntity.self, at: listURI)
                listEntity.addToItems(itemEntity)
            }
            itemEntity.update(name: groceryItem.name, quantity: groceryItem.quantity, price: groceryItem.price,
                              unit: groceryItem.unit, date: groceryItem.date)
            try coreData.saveIfNeeded()
            return .success(())
        } catch let error {
            debugPrint(error)
            return .failure(GroceryError.getAllListsError)
        }
    }

    public func removeGroceryItem(uri: URL) -> Result<Void, Error> {
        do {
            try coreData.remove(itemAt: uri)
            return .success(())
        } catch let error {
            debugPrint(error)
            return .failure(GroceryError.getAllListsError)
        }
    }
}
