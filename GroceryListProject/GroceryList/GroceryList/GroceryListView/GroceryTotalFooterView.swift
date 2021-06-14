//
//  GroceryTotalFooterView.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import UIKit
import Stevia
import ArchitectUtils

final class GroceryTotalFooterView: UICodeView, ContentSizeObserver {

    // Properties

    let totalStackView = UIStackView()

    let titleLabel = UILabel()
    let priceLabel = UILabel()

    var notificationTokens: [NotificationToken] = []

    // Lifecycle

    public override func initSubViews() {
        sv(
            totalStackView.asv(
                titleLabel,
                priceLabel
            )
        )
    }

    public override func initLayout() {
        totalStackView.top(16)
        totalStackView.Leading == safeAreaLayoutGuide.Leading + 16
        totalStackView.Trailing == safeAreaLayoutGuide.Trailing - 16
        totalStackView.Bottom == safeAreaLayoutGuide.Bottom - 16
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = Resources.Colors.footerBackgroundColor
        }

        totalStackView.style { s in
            s.axis = .horizontal
            s.spacing = 4
            bindObserver { c in
                s.axis = c >= .accessibilityLarge ? .vertical : .horizontal
            }
        }

        titleLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProText.semibold.font(.body)
            s.text = Resources.Texts.totalFooterText
            s.adjustsFontForContentSizeCategory = true
        }

        priceLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProText.regular.font(.body)
            s.textAlignment = .right
            s.adjustsFontForContentSizeCategory = true
            bindObserver { c in
                s.textAlignment = c >= .accessibilityLarge ? .left : .right
            }
        }
    }

    // Functions

    func fill(total: String) {
        self.priceLabel.text = total
    }
}
