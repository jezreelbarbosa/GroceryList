//
//  Assets.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit.UIImage

public protocol AssetImage: RawRepresentable {

    var image: UIImage? { get }
}

extension AssetImage where RawValue == String {

    public var image: UIImage? {
        UIImage(named: rawValue, in: Bundle(for: Assets.self), compatibleWith: nil)
    }
}

public final class Assets {

    public enum System: String, AssetImage {

        case trash
        case pencil
    }
}
