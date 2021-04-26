//
//  GroceryListTableViewCell.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import UIKit
import Stevia
import Presentation

final class GroceryListTableViewCell: UICodeTableViewCell, ReuseIdentifiable {

    // Static properties

    static let reuseIdentifier: String = "GroceryListTableViewCell"
    static let rowHeight: CGFloat = 80.0

    // Properties

    let iconLabel = UILabel()

    let infoView = UIView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()

    let topSeparatorLine = UIView()
    let bottomSeparatorLine = UIView()

    var topSeparatorLineHiddenStatus = true
    var bottomSeparatorLineHiddenStatus = true

    // Lifecycle

    public override func initSubViews() {
        sv(
            iconLabel,
            infoView.sv(
                titleLabel,
                dateLabel
            ),
            topSeparatorLine,
            bottomSeparatorLine
        )
    }

    public override func initLayout() {
        iconLabel.centerVertically().leading(16).size(48)
        infoView.Leading == iconLabel.Trailing + 16
        infoView.centerVertically().trailing(16)

        titleLabel.leading(0).trailing(0).top(0)
        titleLabel.Bottom == dateLabel.Top - 8
        dateLabel.leading(0).trailing(0).bottom(0)

        let separatorHeight = 1.0 / UIScreen.main.scale
        topSeparatorLine.leading(0).top(0).height(separatorHeight).width(78)
        bottomSeparatorLine.leading(0).bottom(0).height(separatorHeight).width(78)
    }

    public override func initStyle() {
        style { s in
            s.selectionStyle = .default
            s.accessoryType = .disclosureIndicator
            s.backgroundColor = Resources.Colors.cellBackgroundColor
            s.separatorInset.left = 78
        }

        iconLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProDisplay.semibold.size(40)
            s.textAlignment = .center
        }

        titleLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProDisplay.regular.size(17)
        }
        dateLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProDisplay.light.size(14)
        }

        topSeparatorLine.style { s in
            s.backgroundColor = Resources.Colors.cellSeparatorColor
            s.isHidden = true
        }
        bottomSeparatorLine.style { s in
            s.backgroundColor = Resources.Colors.cellSeparatorColor
            s.isHidden = true
        }
    }

    // Override

    override func prepareForReuse() {
        super.prepareForReuse()

        topSeparatorLine.isHidden = true
        topSeparatorLineHiddenStatus = true

        bottomSeparatorLine.isHidden = true
        bottomSeparatorLineHiddenStatus = true
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        topSeparatorLine.isHidden = highlighted ? true : topSeparatorLineHiddenStatus
        bottomSeparatorLine.isHidden = highlighted ? true : bottomSeparatorLineHiddenStatus
    }

    override func didSet(isFirstCell: Bool, isLastCell: Bool) {
        if isFirstCell {
            topSeparatorLine.isHidden = false
            topSeparatorLineHiddenStatus = false
        }
        if isLastCell {
            bottomSeparatorLine.isHidden = false
            bottomSeparatorLineHiddenStatus = false
        }
    }

    // Functions

    func fill(model: GroceryListHeaderInfoViewModel) {
        iconLabel.text = model.icon
        titleLabel.text = model.name
        dateLabel.text = model.date
    }
}
