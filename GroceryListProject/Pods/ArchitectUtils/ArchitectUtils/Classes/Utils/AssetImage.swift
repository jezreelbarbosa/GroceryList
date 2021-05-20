//
//  AssetImage.swift
//  
//
//  Created by Jezreel Barbosa on 16/04/21.
//

import UIKit.UIImage

public protocol AssetImage: RawRepresentable {

    var image: UIImage? { get }
}

extension AssetImage where RawValue == String {

    public var image: UIImage? {
        UIImage(named: rawValue)
    }
}
