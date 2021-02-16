//
//  Optional+Extension.swift
//  Common
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import Foundation

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
}
