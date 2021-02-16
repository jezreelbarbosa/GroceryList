//
//  GroceryListTableViewCell.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import Presentation
import Stevia

final class GroceryListTableViewCell: UICodeTableViewCell {

    // Static properties

    public override class var reuseIdentifier: String { "GroceryListTableViewCell" }
    static let rowHeight: CGFloat = 72.0

    // Properties

    let iconLabel = UILabel()

    let infoView = UIView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()

    let topSeparatorLine = UIView()
    let bottomSeparatorLine = UIView()

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

        topSeparatorLine.leading(0).top(0).height(0.5).width(78)
        bottomSeparatorLine.leading(0).bottom(0).height(0.5).width(78)

        layoutIfNeeded()
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
            s.font = Font.sfProDisplay(.semibold, size: 40)
            s.textAlignment = .center
        }

        titleLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = Font.sfProDisplay(.regular, size: 17)
        }
        dateLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = Font.sfProDisplay(.light, size: 14)
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

    override func prepareForReuse() {
        super.prepareForReuse()

        topSeparatorLine.isHidden = true
        bottomSeparatorLine.isHidden = true
    }

    // Functions

    func fill(model: GroceryListHeaderInfoViewModel) {
        iconLabel.text = model.icon
        titleLabel.text = model.name
        dateLabel.text = model.date
    }

    func setFirstLastCellFor(row: Int, count: Int) {
        if row == 0 {
            topSeparatorLine.isHidden = false
        }
        if count == row + 1 {
            bottomSeparatorLine.isHidden = false
        }
    }

    // Type

    enum CellType {
        case firstCell
        case lastCell
    }
}
