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
}
