//
//  Defaultable.swift
//  Common
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import Foundation

public protocol Defaultable {

    static var defaultValue: Self { get }
}

public extension Optional where Wrapped: Defaultable {

    var defaultValue: Wrapped { return self ?? Wrapped.defaultValue }
}

// MARK: - Defaultable conformances

extension String: Defaultable {

    public static var defaultValue: String { "" }
}

extension Data: Defaultable {

    public static var defaultValue: Data { Data() }
}

extension Array: Defaultable {

    public static var defaultValue: Array { [] }
}

extension Dictionary: Defaultable {

    public static var defaultValue: [Key: Value] { [:] }
}
