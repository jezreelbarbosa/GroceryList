//
//  Array+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 29/03/21.
//

public extension Array {

    func element(at index: Int) -> Element? {
        guard self.indices.contains(index) else { return nil }
        return self[index]
    }
}
