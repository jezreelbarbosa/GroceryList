//
//  UIFont+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit

class GetBundle {}

extension UIFont {

    static func register(path: String, fileNameString: String, type: String) {
        let frameworkBundle = Bundle(for: GetBundle.self)
        var errorRef: Unmanaged<CFError>? = nil
        guard let resourceBundleURL = frameworkBundle.path(forResource: path + "/" + fileNameString, ofType: type),
              let fontData = NSData(contentsOfFile: resourceBundleURL), let dataProvider = CGDataProvider.init(data: fontData),
              let fontRef = CGFont.init(dataProvider),
              CTFontManagerRegisterGraphicsFont(fontRef, &errorRef)
        else {
            debugPrint("Font Error")
            return
        }
    }
}
