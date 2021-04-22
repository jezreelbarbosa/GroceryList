//
//  NewListView.swift
//  MainList
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import Stevia
import Presentation

final class NewListView: UICodeView {

    // Properties

    let iconTextField = UICodeTextField()
    let nameTextField = UICodeTextField()

    // Lifecycle

    public override func initSubViews() {
        sv(
            iconTextField,
            nameTextField
        )
    }

    public override func initLayout() {
        iconTextField.Top == safeAreaLayoutGuide.Top + 32
        iconTextField.leading(16).size(64).Trailing == nameTextField.Leading - 16
        nameTextField.trailing(16).height(64)
        align(.centerY, views: [iconTextField, nameTextField])

        layoutIfNeeded()
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = Resources.Colors.modalBackgroundColor
        }

        iconTextField.style { s in
            s.font = SFProText.regular.size(40)
            s.textColor = Resources.Colors.textColor
            s.textAlignment = .center
            s.borderStyle = .roundedRect
            s.backgroundColor = Resources.Colors.modalBackgroundColor
            s.text = Resources.Texts.newListIconText
            s.setupCaracterLimit(limit: 1)
        }

        nameTextField.style { s in
            s.font = SFProText.regular.size(24)
            s.textColor = Resources.Colors.textColor
            s.borderStyle = .roundedRect
            s.placeholder = Resources.Texts.newListNameText
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
        iconTextField.text = model.icon
        nameTextField.text = model.name
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
