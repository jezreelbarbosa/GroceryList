//
//  UIStackView+Extension.swift
//  
//
//  Created by Jezreel Barbosa on 08/05/21.
//

import UIKit

public extension UIStackView {

    @discardableResult
    func asv(_ arrengedSubviews: UIView...) -> Self {
        asv(arrengedSubviews)
        return self
    }

    @discardableResult
    func asv(_ arrengedSubviews: [UIView]) -> Self {
        arrengedSubviews.forEach { sv in
            addArrangedSubview(sv)
        }
        return self
    }
}
