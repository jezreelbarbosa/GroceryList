//
//  String+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 30/01/21.
//

public extension String {

    subscript(_ range: CountableRange<Int>) -> String {
        guard self.count >= range.lowerBound else { return "" }

        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound, range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        guard self.count >= range.lowerBound else { return "" }

        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }

    static var newLine: String { "\n" }
}
