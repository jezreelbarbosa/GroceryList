//
//  Commons.swift
//  Common
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit

public typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]

public typealias VoidCompletion = () -> Void

public typealias ResultCompletion<T> = (_ result: Swift.Result<T, Error>) -> Void

public enum CoreError: Error {

    case error
}
