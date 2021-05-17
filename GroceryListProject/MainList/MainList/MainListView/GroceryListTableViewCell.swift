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

    // Properties

    let layoutIconLabel = UILabel()
    let iconLabel = UILabel()

    let infoView = UIView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()

    let topSeparatorLine = UIView()
    let bottomSeparatorLine = UIView()
    let separatorLine = UIView()

    var topSeparatorLineHiddenStatus = true
    var bottomSeparatorLineHiddenStatus = true

    // Lifecycle

    public override func initSubViews() {
        sv(
            layoutIconLabel,
            iconLabel,
            infoView.sv(
                titleLabel,
                dateLabel
            ),
            topSeparatorLine,
            bottomSeparatorLine,
            separatorLine
        )
    }

    public override func initLayout() {
        iconLabel.followEdges(layoutIconLabel)
        layoutIconLabel.centerVertically().leading(16).top(>=4).bottom(>=4)
        layoutIconLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        layoutIconLabel.setContentHuggingPriority(.required, for: .horizontal)
        infoView.Leading == layoutIconLabel.Trailing + 16
        infoView.centerVertically().trailing(16).top(>=16).bottom(>=16)

        titleLabel.leading(0).trailing(0).top(0)
        titleLabel.Bottom == dateLabel.Top - 8
        dateLabel.leading(0).trailing(0).bottom(0)

        let separatorHeight = 1.0 / UIScreen.main.scale
        topSeparatorLine.leading(0).top(0).height(separatorHeight).Trailing == Trailing
        bottomSeparatorLine.leading(0).bottom(0).height(separatorHeight).Trailing == separatorLine.Leading
        separatorLine.bottom(0).height(separatorHeight).Leading == infoView.Leading
        separatorLine.Trailing == Trailing
    }

    public override func initStyle() {
        style { s in
            s.selectionStyle = .default
            s.accessoryType = .disclosureIndicator
            s.backgroundColor = Resources.Colors.cellBackgroundColor
        }

        layoutIconLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProDisplay.semibold.font(.largeTitle, size: 40)
            s.adjustsFontForContentSizeCategory = true
            s.textAlignment = .center
            s.text = "⬜️"
            s.alpha = 0
        }

        iconLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProDisplay.semibold.font(.largeTitle, size: 40)
            s.adjustsFontForContentSizeCategory = true
            s.textAlignment = .center
        }

        titleLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProDisplay.regular.font(.body)
            s.adjustsFontForContentSizeCategory = true
        }

        dateLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProDisplay.light.font(.footnote)
            s.adjustsFontForContentSizeCategory = true
        }

        topSeparatorLine.style { s in
            s.backgroundColor = Resources.Colors.cellSeparatorColor
            s.isHidden = true
        }

        bottomSeparatorLine.style { s in
            s.backgroundColor = Resources.Colors.cellSeparatorColor
            s.isHidden = true
        }

        separatorLine.style { s in
            s.backgroundColor = Resources.Colors.cellSeparatorColor
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
        separatorLine.isHidden = highlighted
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

    func fill(model: GroceryListHeaderInfoViewModel?) {
        guard let model = model else { return }

        iconLabel.text = model.icon
        titleLabel.text = model.name
        dateLabel.text = model.date
    }
}
