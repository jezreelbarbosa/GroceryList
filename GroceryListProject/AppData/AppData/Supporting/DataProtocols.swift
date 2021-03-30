//
//  DataProtocols.swift
//  AppData
//
//  Created by Jezreel Barbosa on 16/02/21.
//

public protocol DataError: Equatable, Error {

    static var numberPrefix: String { get }
}
