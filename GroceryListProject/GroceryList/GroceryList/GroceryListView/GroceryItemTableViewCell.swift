//
//  GroceryItemTableViewCell.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import UIKit
import Stevia
import Presentation

final class GroceryItemTableViewCell: UICodeTableViewCell, ReuseIdentifiable, ContentSizeObserver {

    // Static properties

    static let reuseIdentifier: String = "GroceryItemTableViewCell"

    // Properties

    let cellStackView = UIStackView()
    let textStackView = UIStackView()

    let nameLabel = UILabel()
    let detailsLabel = UILabel()

    let priceLabel = UILabel()

    var notificationTokens: [NotificationToken] = []

    // Lifecycle

    public override func initSubViews() {
        sv(
            cellStackView.asv(
                textStackView.asv(
                    nameLabel,
                    detailsLabel
                ),
                priceLabel
            )
        )
    }

    public override func initLayout() {
        cellStackView.fillContainer(16)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    public override func initStyle() {
        style { s in
            s.selectionStyle = .default
            s.backgroundColor = Resources.Colors.cellBackgroundColor
        }

        textStackView.style { s in
            s.axis = .vertical
            s.spacing = 4
        }

        cellStackView.style { s in
            s.axis = .horizontal
            s.spacing = 4
            bindObserver { category in
                s.axis = category >= .accessibilityMedium ? .vertical : .horizontal
            }
        }

        nameLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProText.semibold.font(.body)
        }

        detailsLabel.style { s in
            s.textColor = Resources.Colors.detailColor
            s.font = SFProText.light.font(.footnote)
            s.numberOfLines = 2
        }

        priceLabel.style { s in
            s.textColor = Resources.Colors.textColor
            s.font = SFProText.regular.font(.body)
            s.textAlignment = .right
            bindObserver { category in
                s.textAlignment = category >= .accessibilityMedium ? .left : .right
            }
        }
    }

    // Functions

    func fill(model: GroceryItemViewModel?) {
        guard let model = model else { return }

        self.nameLabel.text = model.name
        self.detailsLabel.text = model.details
        self.priceLabel.text = model.totalPrice
    }
}
