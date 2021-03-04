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

    public func getGroceryMainList() -> Result<[GroceryListHeaderInfoResponse], Error> {
        local.getGroceryMainList().map { newSuccess in
            newSuccess.map { response in
                GroceryListHeaderInfoResponse(id: response.id, icon: response.icon, name: response.name, date: response.date)
            }
        }
    }

    public func saveNewGroceryList(request: NewGroceryListRequest) -> Result<Void, Error> {
        let requestDTO = GroceryListCompleteInfoResponseDTO(
            id: UUID(), icon: request.icon, name: request.name, date: request.date, items: []
        )
        return local.saveNewGroceryList(request: requestDTO)
    }

    public func removeGroceryList(id: UUID) -> Result<Void, Error> {
        local.removeGroceryList(id: id)
    }

    public func getGroceryList(id: UUID) -> Result<GroceryListModel, Error> {
        local.getGroceryList(id: id).map { newSuccess in
            GroceryListModel(id: newSuccess.id, name: newSuccess.name, items: newSuccess.items.map { item in
                GroceryItemModel(id: item.id, listID: newSuccess.id, name: item.name, quantity: item.quantity,
                                 unit: GroceryItemModel.Unit(rawValue: item.unit) ?? .unit, price: item.price)
            })
        }
    }

    public func updateGroceryList(model: GroceryListModel) -> Result<Void, Error> {
        local.update(groceryList: GroceryListUpdatedItemsDTO(from: model))
    }

    public func updateGroceryItem(model: GroceryItemModel) -> Result<Void, Error> {
        local.update(groceryItem: GroceryItemDTO(from: model), listID: model.listID)
    }
}
