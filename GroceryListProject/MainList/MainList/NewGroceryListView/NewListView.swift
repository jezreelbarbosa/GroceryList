//
//  NewListView.swift
//  MainList
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import UIKit
import Stevia
import Presentation

final class NewListView: UICodeView, ContentSizeObserver {

    // Properties

    let infoStackView = UIStackView()
    let iconTextField = UICodeTextField()
    let nameTextField = UICodeTextField()

    var notificationTokens: [NotificationToken] = []

    // Lifecycle

    public override func initSubViews() {
        sv(
            infoStackView.asv(
                iconTextField,
                nameTextField
            )
        )
    }

    public override func initLayout() {
        infoStackView.fillHorizontally(m: 16).Top == safeAreaLayoutGuide.Top + 32
        infoStackView.leadingConstraint?.priority = .required
        infoStackView.trailingConstraint?.priority = .required
        iconTextField.size(64).setContentCompressionResistancePriority(.required, for: .horizontal)
        nameTextField.height(64)

        iconTextField.heightConstraint?.scaledConstant()
        iconTextField.widthConstraint?.scaledConstant().priority = .init(1)
        nameTextField.heightConstraint?.scaledConstant()
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = Resources.Colors.modalBackgroundColor
        }

        infoStackView.style { s in
            s.axis = .horizontal
            s.spacing = 16
            bindObserver { c in
                s.axis = c >= .accessibilityMedium ? .vertical : .horizontal
                s.spacing = c >= .accessibilityMedium ? 8 : 16
            }
        }

        iconTextField.style { s in
            s.font = SFProText.regular.font(size: 40)
            s.textColor = Resources.Colors.textColor
            s.textAlignment = .center
            s.borderStyle = .roundedRect
            s.attributedPlaceholder = NSAttributedString(
                string: "", attributes: [.font: SFProText.regular.font(size: 40)]
            )
            s.backgroundColor = Resources.Colors.modalBackgroundColor
            s.setupCharacterLimit(limit: 1)
            s.setLimited(text: Resources.Texts.newListIconText)
        }

        nameTextField.style { s in
            s.font = SFProText.regular.font(size: 24)
            s.textColor = Resources.Colors.textColor
            s.borderStyle = .roundedRect
            s.attributedPlaceholder = NSAttributedString(
                string: Resources.Texts.newListNameText,
                attributes: [.font: SFProText.regular.font(size: 24)]
            )
            s.text = Resources.Texts.newListNameText
            s.padding.left = 16
            s.padding.right = 16
            s.backgroundColor = Resources.Colors.modalBackgroundColor
            s.addTarget(self, action: #selector(nameTextFieldEditingChanged), for: .editingChanged)
            s.sendActions(for: .editingChanged)
        }
    }

    // Functions

    func set(model: GroceryListHeaderInfoViewModel) {
        iconTextField.setLimited(text: model.icon)
        nameTextField.text = model.name
    }

    func getModel() -> GroceryListHeaderInfoViewModel {
        let isNameEmpty = nameTextField.text.defaultValue.isEmpty
        let name = isNameEmpty ? nameTextField.placeholder.defaultValue : nameTextField.text.defaultValue
        return GroceryListHeaderInfoViewModel(icon: iconTextField.text.defaultValue, name: name, date: .defaultValue)
    }

    // Actions

    @objc private func nameTextFieldEditingChanged() {
        let letter: String
        if let text = nameTextField.text, !text.isEmpty {
            letter = text[0..<1]
        } else {
            letter = (nameTextField.placeholder?[0..<1]).defaultValue
        }

        iconTextField.placeholder = letter
    }
}
