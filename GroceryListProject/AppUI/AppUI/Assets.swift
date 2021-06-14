//
//  Assets.swift
//  AppUI
//
//  Created by Jezreel Barbosa on 26/04/21.
//

import ArchitectUtils

public final class Assets {

    public enum Icons: String, AssetImage {

        case pencil
        case trash
        case checkmark
        case xmark
    }
}

public extension UIImage {

    var template: UIImage {
        withRenderingMode(.alwaysTemplate)
    }

    var original: UIImage {
        withRenderingMode(.alwaysOriginal)
    }
}
