//
//  UICodeTableViewHeaderFooterView.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import UIKit

open class UICodeTableViewHeaderFooterView: UITableViewHeaderFooterView {

    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        initSubViews()
        initLayout()
        initStyle()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        initSubViews()
        initLayout()
        initStyle()
    }

    open func initSubViews() {}
    open func initLayout() {}
    open func initStyle() {}
}
