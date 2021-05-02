//
//  GroceryItemTableViewCell.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import UIKit
import Stevia
import Presentation

final class GroceryItemTableViewCell: UICodeTableViewCell, ReuseIdentifiable {

    // Static properties

    static let reuseIdentifier: String = "GroceryItemTableViewCell"

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
        textView.leading(16).centerVertically().top(>=16).bottom(>=16)
        textView.Trailing == priceLabel.Leading + 16

        nameLabel.leading(0).top(0).trailing(0).Bottom == detailsLabel.Top - 4
        detailsLabel.leading(0).trailing(0).bottom(0)

        priceLabel.centerVertically().trailing(16).top(>=16).bottom(>=16)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    public override func initStyle() {
        style { s in
            s.selectionStyle = .default
            s.backgroundColor = Resources.Colors.cellBackgroundColor
        }

        nameLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProText.semibold.font(.body)
        }

        detailsLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProText.light.font(.footnote)
        }

        priceLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProText.regular.font(.body)
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
