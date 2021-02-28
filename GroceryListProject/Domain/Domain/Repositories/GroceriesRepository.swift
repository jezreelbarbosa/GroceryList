//
//  GroceriesRepository.swift
//  Domain
//
//  Created by Jezreel Barbosa on 11/02/21.
//

public protocol GroceriesRepository {

    func getGroceryMainList() -> Result<[GroceryListHeaderInfoResponse], Error>
    func saveNewGroceryList(request: NewGroceryListRequest) -> Result<Void, Error>
    func removeGroceryList(id: UUID) -> Result<Void, Error>
    func getGroceryList(id: UUID) -> Result<GroceryListModel, Error>
    func updateGroceryList(model: GroceryListModel) -> Result<Void, Error>
}
