//
//  GroceriesLocalDataSource.swift
//  AppData
//
//  Created by Jezreel Barbosa on 11/02/21.
//

public protocol GroceriesLocalDataSource {

    func getGroceryMainList() -> Result<[GroceryListDTO], Error>
    func saveNewGroceryList(request: GroceryListDTO) -> Result<Void, Error>
    func removeGroceryList(uri: URL) -> Result<Void, Error>

    func getGroceryList(uri: URL) -> Result<GroceryListDTO, Error>
    func getGroceryItem(uri: URL) -> Result<GroceryItemDTO, Error>
    func addOrUpdate(groceryItem: GroceryItemDTO, into listURI: URL) -> Result<Void, Error>
    func removeGroceryItem(uri: URL) -> Result<Void, Error>
}
