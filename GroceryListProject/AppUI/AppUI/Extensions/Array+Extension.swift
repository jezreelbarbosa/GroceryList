//
//  Array+Extension.swift
//  AppUI
//
//  Created by Jezreel Barbosa on 17/05/21.
//

import ArchitectUtils

public protocol StringSortable {

    var sortString: String { get }
}

public extension Array where Element: StringSortable {

    func filterContains(_ string: String) -> Self {
        filter { element in
            element.sortString.lowercased().contains(string)
        }
    }

    func prefixSorted(by string: String) -> Self {
        sorted { a, b in
            let aName = a.sortString.lowercased()
            let bName = b.sortString.lowercased()
            let isAEqual = aName.prefix(string.count) == string
            let isBEqual = bName.prefix(string.count) == string

            if isAEqual == isBEqual {
                return aName < bName
            } else {
                return isAEqual
            }
        }
    }
}
