//
//  ReuseIdentifiable.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 15/03/21.
//

import Foundation

public protocol ReuseIdentifiable {

    static var reuseIdentifier: String { get }
}

public extension ReuseIdentifiable {

    static var reuseIdentifier: String {
        String(describing: self)
    }
}
