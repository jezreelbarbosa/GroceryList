//
//  Optional+Extension.swift
//  Common
//
//  Created by Jezreel Barbosa on 16/02/21.
//

extension Optional {

    static public func ==<T: Comparable>(lhs: T?, rhs: T?) -> Bool {
        switch (lhs, rhs) {
        case (.some(let lhs), .some(let rhs)):
            return lhs == rhs
        case (.none, .none):
            return true
        default:
            return false
        }
    }

    public var isNil: Bool {
        self == nil
    }

    public var isNotNil: Bool {
        self != nil
    }
}
