//
//  Mask+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 17/02/21.
//

import InputMask

public extension Mask {

    enum Formats: String {
        case singleLetter = "[-]"

        case test0 = "[0]{-}[0]"
        case test1 = "[00]{-}[0]"
        case test2 = "[000]{-}[0]"
        case test3 = "[0000]{-}[0]"
        case test4 = "[00000]{-}[0]"
        case test5 = "[000000]{-}[0]"
        case test6 = "[0000000]{-}[0]"
        case test7 = "[00000000]{-}[0]"
        case test8 = "[000000000]{-}[0]"

        public var format: String {
            return rawValue
        }
    }
}
