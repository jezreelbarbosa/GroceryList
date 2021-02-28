//
//  UICodeTableViewHeaderFooterView.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import UIKit

open class UICodeTableViewHeaderFooterView: UITableViewHeaderFooterView {

    open class var reuseIdentifier: String { String(describing: self) }

    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        initSubViews()
        initLayout()
        initStyle()
    }

    public required init?(coder: NSCoder) { fatalError() }

    open func initSubViews() {}
    open func initLayout() {}
    open func initStyle() {}
}
