//
//  StorageErrors.swift
//  Storage
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import AppData

public enum GroceryError: String, DataError {

    public static let numberPrefix: String = "S - 1"

    case getListError = "01"
}
