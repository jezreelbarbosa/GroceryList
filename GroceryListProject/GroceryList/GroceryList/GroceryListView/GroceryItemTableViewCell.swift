//
//  GroceryItemTableViewCell.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Stevia

final class GroceryItemTableViewCell: UICodeTableViewCell, ReuseIdentifiable {

    // Static properties

    static let reuseIdentifier: String = "GroceryItemTableViewCell"
    static let rowHeight: CGFloat = 72.0

    // Properties

    let textView = UIView()
    let nameLabel = UILabel()
    let detailsLabel = UILabel()

    let priceLabel = UILabel()

    // Lifecycle

    public override func initSubViews() {
        sv(
            textView.sv(
                nameLabel,
                detailsLabel
            ),
            priceLabel
        )
    }

    public override func initLayout() {
        textView.leading(16).centerVertically().Trailing == priceLabel.Leading + 16

        nameLabel.leading(0).top(0).trailing(0).Bottom == detailsLabel.Top
        detailsLabel.leading(0).trailing(0).bottom(0)

        priceLabel.centerVertically().trailing(16)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        layoutIfNeeded()
    }

    public override func initStyle() {
        style { s in
            s.selectionStyle = .default
            s.backgroundColor = Resources.Colors.cellBackgroundColor
        }

        nameLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = Font.sfProText(.semibold, size: 17)
        }

        detailsLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = Font.sfProText(.light, size: 14)
        }

        priceLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = Font.sfProText(.regular, size: 17)
            s.textAlignment = .right
        }
    }

    // Functions

    func fill(model: GroceryItemViewModel) {
        self.nameLabel.text = model.name
        self.detailsLabel.text = model.details
        self.priceLabel.text = model.totalPrice
    }
}
