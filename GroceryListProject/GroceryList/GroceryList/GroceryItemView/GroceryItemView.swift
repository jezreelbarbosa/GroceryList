//
//  GroceryItemView.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 28/02/21.
//

import UIKit
import Stevia
import Presentation

final class GroceryItemView: UICodeView {

    // Properties

    let itemNameTextField = UICodeTextField()

    let priceLabel = UILabel()
    let priceDecimalField = UIDecimalField()

    let unitSegmentedControl = UISegmentedControl()

    let quantityLabel = UILabel()
    let quantityDecimalField = UIDecimalField()

    let separatorView = UIView()

    let totalNameLabel = UILabel()
    let totalPriceLabel = UILabel()

    var itemDate = Date()

    // Lifecycle

    public override func initSubViews() {
        sv(
            itemNameTextField,
            priceLabel,
            priceDecimalField,
            unitSegmentedControl,
            quantityLabel,
            quantityDecimalField,
            separatorView,
            totalNameLabel,
            totalPriceLabel
        )
    }

    public override func initLayout() {
        itemNameTextField.height(34).leading(16).trailing(16).Top == safeAreaLayoutGuide.Top + 24

        priceDecimalField.height(34).Top == itemNameTextField.Bottom + 8
        priceLabel.leading(16).CenterY == priceDecimalField.trailing(16).CenterY
        priceLabel.Trailing == priceDecimalField.Leading - 8
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        priceLabel.setContentHuggingPriority(.required, for: .horizontal)

        unitSegmentedControl.height(34).leading(16).trailing(16).Top == priceDecimalField.Bottom + 8

        quantityDecimalField.height(34).Top == unitSegmentedControl.Bottom + 8
        quantityLabel.leading(16).CenterY == quantityDecimalField.trailing(16).CenterY
        quantityLabel.Trailing == quantityDecimalField.Leading - 8
        quantityLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        quantityLabel.setContentHuggingPriority(.required, for: .horizontal)

        let separatorHeight = 1.0 / UIScreen.main.scale
        separatorView.leading(16).trailing(16).height(separatorHeight).Top == quantityDecimalField.Bottom + 16

        totalPriceLabel.Top == separatorView.Bottom + 16
        totalNameLabel.leading(16).CenterY == totalPriceLabel.trailing(16).CenterY
        totalNameLabel.Trailing == totalPriceLabel.Leading + 8
        totalNameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        itemNameTextField.heightConstraint?.scaledConstant()
        priceDecimalField.heightConstraint?.scaledConstant()
        unitSegmentedControl.heightConstraint?.scaledConstant()
        quantityDecimalField.heightConstraint?.scaledConstant()
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = Resources.Colors.modalBackgroundColor
        }

        itemNameTextField.style { s in
            s.font = SFProText.regular.font(.body)
            s.textColor = Resources.Colors.textColor
            s.backgroundColor = Resources.Colors.modalBackgroundColor
            s.attributedPlaceholder = NSAttributedString(
                string: Resources.Texts.itemNamePlaceholder,
                attributes: [.font: SFProText.regular.font(.body)]
            )
            s.borderStyle = .roundedRect
            s.padding.left = 16
            s.padding.right = 16
            s.adjustsFontForContentSizeCategory = true
        }

        priceLabel.style { s in
            s.font = SFProText.regular.font(.body)
            s.textColor = Resources.Colors.textColor
            s.text = Resources.Texts.priceText
            s.adjustsFontForContentSizeCategory = true
        }

        priceDecimalField.style { s in
            s.font = SFProText.regular.font(.body)
            s.textColor = Resources.Colors.textColor
            s.backgroundColor = Resources.Colors.modalBackgroundColor
            s.attributedPlaceholder = NSAttributedString(
                string: "", attributes: [.font: SFProText.regular.font(.body)]
            )
            s.borderStyle = .roundedRect
            s.numberStyle = .currency
            s.adjustsFontForContentSizeCategory = true
            s.sendActions(for: .editingChanged)
            s.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        }

        unitSegmentedControl.style { s in
            s.font = SFProText.regular.font(.footnote)
            s.insertSegment(withTitle: Resources.Texts.unitUnit, at: 0, animated: false)
            s.insertSegment(withTitle: Resources.Texts.unitKilogram, at: 1, animated: false)
            s.insertSegment(withTitle: Resources.Texts.unitHundredGrams, at: 2, animated: false)
            s.insertSegment(withTitle: Resources.Texts.unitLiter, at: 3, animated: false)
            s.selectedSegmentIndex = 0
            s.addTarget(self, action: #selector(updateQuantityDecimalField), for: .valueChanged)
        }

        quantityLabel.style { s in
            s.font = SFProText.regular.font(.body)
            s.textColor = Resources.Colors.textColor
            s.text = Resources.Texts.quantityText
            s.adjustsFontForContentSizeCategory = true
        }

        quantityDecimalField.style { s in
            s.font = SFProText.regular.font(.body)
            s.textColor = Resources.Colors.textColor
            s.backgroundColor = Resources.Colors.modalBackgroundColor
            s.attributedPlaceholder = NSAttributedString(
                string: "", attributes: [.font: SFProText.regular.font(.body)]
            )
            s.borderStyle = .roundedRect
            s.fractionDigits = 0
            s.adjustsFontForContentSizeCategory = true
            s.sendActions(for: .editingChanged)
            s.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        }

        separatorView.style { s in
            s.backgroundColor = Resources.Colors.separatorColor
        }

        totalNameLabel.style { s in
            s.font = SFProText.regular.font(.body)
            s.textColor = Resources.Colors.textColor
            s.text = Resources.Texts.totalText
            s.adjustsFontForContentSizeCategory = true
        }

        totalPriceLabel.style { s in
            s.font = SFProText.regular.font(.body)
            s.textColor = Resources.Colors.textColor
            s.textAlignment = .right
            s.adjustsFontForContentSizeCategory = true
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
