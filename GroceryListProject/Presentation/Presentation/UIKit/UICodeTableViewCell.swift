//
//  UICodeTableViewCell.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import UIKit

open class UICodeTableViewCell: UITableViewCell {

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initSubViews()
        initLayout()
        initStyle()
    }

    public required init?(coder: NSCoder) { fatalError() }

    open func initSubViews() {}
    open func initLayout() {}
    open func initStyle() {}
}
