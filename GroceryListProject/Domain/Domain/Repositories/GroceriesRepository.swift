//
//  GroceriesRepository.swift
//  Domain
//
//  Created by Jezreel Barbosa on 11/02/21.
//

public protocol GroceriesRepository {

    func getGroceryMainList() -> Result<[GroceryListModel], Error>
    func saveNewGroceryList(request: NewGroceryListRequest) -> Result<Void, Error>
    func addOrUpdate(groceryList: GroceryListModel) -> Result<Void, Error>
    func removeGroceryList(uri: URL) -> Result<Void, Error>

    func getGroceryList(uri: URL) -> Result<GroceryListModel, Error>
    func getGroceryItem(uri: URL) -> Result<GroceryItemModel, Error>
    func addOrUpdate(groceryItem: GroceryItemModel, into listURI: URL) -> Result<Void, Error>
    func removeGroceryItem(uri: URL) -> Result<Void, Error>
}
