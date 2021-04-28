//
//  GroceryTotalFooterView.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import UIKit
import Stevia
import Presentation

final class GroceryTotalFooterView: UICodeTableViewHeaderFooterView, ReuseIdentifiable {

    // Static properties

    static let reuseIdentifier: String = "GroceryTotalFooterView"
    static let rowHeight: CGFloat = 44.0

    // Properties

    let titleLabel = UILabel()
    let priceLabel = UILabel()

    // Lifecycle

    public override func initSubViews() {
        sv(
            titleLabel,
            priceLabel
        )
    }

    public override func initLayout() {
        titleLabel.leading(16).centerVertically().Trailing == priceLabel.Leading + 16

        priceLabel.centerVertically().trailing(16)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        layoutIfNeeded()
    }

    public override func initStyle() {
        style { s in
            s.backgroundView?.backgroundColor = Resources.Colors.footerBackgroundColor
        }

        titleLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProText.semibold.font(.body)
            s.text = Resources.Texts.totalFooterText
        }

        priceLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProText.regular.font(.body)
            s.textAlignment = .right
        }
    }

    // Functions

    func fill(total: String) {
        self.priceLabel.text = total
    }
}
