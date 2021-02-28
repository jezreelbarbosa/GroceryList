//
//  StorageErrors.swift
//  Storage
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import AppData

public enum GroceryError: String, DataError {

    public static let numberPrefix: String = "S - 1"

    case getAllListsError = "01"
    case saveNewListError = "02"
    case removeListError = "03"
    case getListError = "04"
    case updateListError = "05"
}
