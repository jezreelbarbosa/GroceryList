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

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        initSubViews()
        initLayout()
        initStyle()
    }

    open func initSubViews() {}
    open func initLayout() {}
    open func initStyle() {}

    open func didSet(isFirstCell: Bool, isLastCell: Bool) {}
}

public extension UICodeTableViewCell {

    final func setFirstLastCellFor(row: Int, count: Int) {
        didSet(isFirstCell: row == 0, isLastCell: count == row + 1)
    }
}
