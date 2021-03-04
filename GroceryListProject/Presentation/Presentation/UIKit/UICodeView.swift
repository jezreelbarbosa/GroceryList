//
//  UICodeView.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import UIKit

open class UICodeView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)

        initSubViews()
        initLayout()
        initStyle()
    }

    public required init?(coder: NSCoder) { fatalError() }

    open func initSubViews() {}
    open func initLayout() {}
    open func initStyle() {}
}
