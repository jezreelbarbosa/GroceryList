//
//  GroceryItemView.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 28/02/21.
//

import UIKit
import Stevia
import ArchitectUtils
import IQKeyboardManagerSwift

public final class GroceryItemView: UICodeView, ContentSizeObserver {

    // Properties

    let scrollView = UIScrollView()
    let contentView = IQPreviousNextView()

    let itemNameTextField = UICodeTextField()

    let priceStackView = UIStackView()
    let priceLabel = UILabel()
    let priceDecimalField = UIDecimalField()

    let unitSegmentedControl = UICodeSegmentedControl()

    let quantityStackView = UIStackView()
    let quantityLabel = UILabel()
    let quantityDecimalField = UIDecimalField()

    let separatorView = UIView()

    let totalStackView = UIStackView()
    let totalNameLabel = UILabel()
    let totalPriceLabel = UILabel()

    var itemDate = Date()

    public var notificationTokens: [NotificationToken] = []

    // Lifecycle

    public override func initSubViews() {
        sv(
            scrollView.sv(
                contentView
            )
        )
        contentView.sv(
            itemNameTextField,
            priceStackView.asv(
                priceLabel,
                priceDecimalField
            ),
            unitSegmentedControl,
            quantityStackView.asv(
                quantityLabel,
                quantityDecimalField
            ),
            separatorView,
            totalStackView.asv(
                totalNameLabel,
                totalPriceLabel
            )
        )
    }

    public override func initLayout() {
        scrollView.Top == safeAreaLayoutGuide.Top
        scrollView.Bottom == safeAreaLayoutGuide.Bottom
        scrollView.Leading == safeAreaLayoutGuide.Leading
        scrollView.Trailing == safeAreaLayoutGuide.Trailing

        contentView.Leading == safeAreaLayoutGuide.Leading
        contentView.Trailing == safeAreaLayoutGuide.Trailing
        contentView.fillContainer()

        itemNameTextField.top(24).height(36).leading(16).trailing(16)

        priceStackView.fillHorizontally(m: 16).Top == itemNameTextField.Bottom + 8
        priceDecimalField.height(36).Width == priceStackView.Width
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        unitSegmentedControl.height(36).leading(16).trailing(16).Top == priceStackView.Bottom + 8

        quantityStackView.fillHorizontally(m: 16).Top == unitSegmentedControl.Bottom + 8
        quantityDecimalField.height(36).Width == quantityStackView.Width
        quantityLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        let separatorHeight = 1.0 / UIScreen.main.scale
        separatorView.leading(16).trailing(16).height(separatorHeight).Top == quantityDecimalField.Bottom + 16

        totalStackView.fillHorizontally(m: 16).bottom(24).Top == separatorView.Bottom + 16
        totalPriceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        itemNameTextField.heightConstraint?.scaledConstant()
        priceDecimalField.heightConstraint?.scaledConstant()
        unitSegmentedControl.heightConstraint?.scaledConstant()
        quantityDecimalField.heightConstraint?.scaledConstant()
    }

    // swiftlint:disable function_body_length
    public override func initStyle() {
        style { s in
            s.backgroundColor = Resources.Colors.modalBackgroundColor
        }

        scrollView.style { s in
            s.showsVerticalScrollIndicator = true
        }

        itemNameTextField.style { s in
            s.font = SFProText.regular.font(.body)
            s.adjustsFontForContentSizeCategory = true
            s.textColor = Resources.Colors.textColor
            s.backgroundColor = Resources.Colors.modalBackgroundColor
            s.attributedPlaceholder = NSAttributedString(
                string: Resources.Texts.itemNamePlaceholder,
                attributes: [.font: SFProText.regular.font(.body)]
            )
            s.borderStyle = .roundedRect
            s.padding.left = 16
            s.padding.right = 16
        }

        priceStackView.style { s in
            s.axis = .horizontal
            s.spacing = 8
            bindObserver { c in
                s.axis = c >= .accessibilityMedium ? .vertical : .horizontal
                s.spacing = c >= .accessibilityMedium ? 4 : 8
            }
        }

        priceLabel.style { s in
            s.font = SFProText.regular.font(.body)
            s.adjustsFontForContentSizeCategory = true
            s.textColor = Resources.Colors.textColor
            s.text = Resources.Texts.priceText
        }

        priceDecimalField.style { s in
            s.font = SFProText.regular.font(.body)
            s.adjustsFontForContentSizeCategory = true
            s.textColor = Resources.Colors.textColor
            s.backgroundColor = Resources.Colors.modalBackgroundColor
            s.attributedPlaceholder = NSAttributedString(
                string: "", attributes: [.font: SFProText.regular.font(.body)]
            )
            s.borderStyle = .roundedRect
            s.numberStyle = .currency
            s.padding.left = 16
            s.padding.right = 16
            s.sendActions(for: .editingChanged)
            s.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
            bindObserver { c in
                s.textAlignment = c >= .accessibilityMedium ? .left : .right
            }
        }

        unitSegmentedControl.style { s in
            s.setScaledFont(for: .normal, font: { SFProDisplay.regular.font(.subheadline) })
            s.insertSegment(withTitle: Resources.Texts.unitUnit, at: 0, animated: false)
            s.insertSegment(withTitle: Resources.Texts.unitKilogram, at: 1, animated: false)
            s.insertSegment(withTitle: Resources.Texts.unitHundredGrams, at: 2, animated: false)
            s.insertSegment(withTitle: Resources.Texts.unitLiter, at: 3, animated: false)
            s.selectedSegmentIndex = 0
            s.addTarget(self, action: #selector(updateQuantityDecimalField), for: .valueChanged)
        }

        quantityStackView.style { s in
            s.axis = .horizontal
            s.spacing = 8
            bindObserver { c in
                s.axis = c >= .accessibilityMedium ? .vertical : .horizontal
                s.spacing = c >= .accessibilityMedium ? 4 : 8
            }
        }

        quantityLabel.style { s in
            s.font = SFProText.regular.font(.body)
            s.adjustsFontForContentSizeCategory = true
            s.textColor = Resources.Colors.textColor
            s.text = Resources.Texts.quantityText
        }

        quantityDecimalField.style { s in
            s.font = SFProText.regular.font(.body)
            s.adjustsFontForContentSizeCategory = true
            s.textColor = Resources.Colors.textColor
            s.backgroundColor = Resources.Colors.modalBackgroundColor
            s.attributedPlaceholder = NSAttributedString(
                string: "", attributes: [.font: SFProText.regular.font(.body)]
            )
            s.borderStyle = .roundedRect
            s.fractionDigits = 0
            s.padding.left = 16
            s.padding.right = 16
            s.sendActions(for: .editingChanged)
            s.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
            bindObserver { c in
                s.textAlignment = c >= .accessibilityMedium ? .left : .right
            }
        }

        separatorView.style { s in
            s.backgroundColor = Resources.Colors.separatorColor
        }

        totalStackView.style { s in
            s.axis = .horizontal
            s.spacing = 8
            bindObserver { c in
                s.axis = c >= .accessibilityMedium ? .vertical : .horizontal
                s.spacing = c >= .accessibilityMedium ? 4 : 8
            }
        }

        totalNameLabel.style { s in
            s.font = SFProText.regular.font(.body)
            s.adjustsFontForContentSizeCategory = true
            s.textColor = Resources.Colors.textColor
            s.text = Resources.Texts.totalText
        }

        totalPriceLabel.style { s in
            s.font = SFProText.regular.font(.body)
            s.adjustsFontForContentSizeCategory = true
            s.textColor = Resources.Colors.textColor
            s.textAlignment = .right
            bindObserver { c in
                s.textAlignment = c >= .accessibilityMedium ? .left : .right
            }
        }

        textFieldEditingChanged()
    }

    // Functions

    func getItem() -> GroceryItemUpdateRequest {
        GroceryItemUpdateRequest(
            itemName: itemNameTextField.text.defaultValue,
            price: priceDecimalField.decimal,
            unit: unitSegmentedControl.selectedSegmentIndex,
            quantity: quantityDecimalField.decimal,
            date: itemDate
        )
    }

    func setItem(item: GroceryItemUpdateRequest) {
        itemDate = item.date
        unitSegmentedControl.selectedSegmentIndex = item.unit
        updateQuantityDecimalField()
        quantityDecimalField.decimal = item.quantity
        itemNameTextField.text = item.itemName
        priceDecimalField.decimal = item.price
        textFieldEditingChanged()
    }

    // Actions

    @objc func textFieldEditingChanged() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = .current

        let factor: Decimal = unitSegmentedControl.selectedSegmentIndex == 2 ? 10 : 1
        let total = priceDecimalField.decimal * quantityDecimalField.decimal * factor

        totalPriceLabel.text = numberFormatter.string(for: total)
    }

    @objc func updateQuantityDecimalField() {
        let digits = unitSegmentedControl.selectedSegmentIndex == 0 ? 0 : 3
        quantityDecimalField.fractionDigits = digits
    }
}
