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
            return.failure(GroceryError.getListError)
        }
    }
}
