//
//  GroceriesRepository.swift
//  Domain
//
//  Created by Jezreel Barbosa on 11/02/21.
//

import Foundation

public protocol GroceriesRepository {

    func getGroceryMainList() -> Result<[GroceryListHeaderInfoResponse], Error>
}
