//
//  DataProtocols.swift
//  AppData
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import Foundation

public typealias DataCompletion<T> = (_ result: Swift.Result<T, Error>) -> Void

public protocol DataError: Equatable, Error {

    static var numberPrefix: String { get }
}
