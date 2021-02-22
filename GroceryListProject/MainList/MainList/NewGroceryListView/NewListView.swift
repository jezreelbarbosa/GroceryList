//
//  NewListView.swift
//  MainList
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import Presentation
import Stevia

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
        iconTextField.Top == safeAreaLayoutGuide.Top + 24
        iconTextField.leading(16).size(48).Trailing == nameTextField.Leading - 24
        nameTextField.trailing(16)
        align(.centerY, views: [iconTextField, nameTextField])

        layoutIfNeeded()
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = Resources.Colors.modalBackgroundColor
        }

        iconTextField.style { s in
            s.font = Font.sfProText(.regular, size: 40)
            s.textColor = Resources.Colors.textColor
            s.textAlignment = .center
            s.borderStyle = .none
            s.setupCaracterLimit(limit: 1)
        }

        nameTextField.style { s in
            s.font = Font.sfProText(.regular, size: 24)
            s.textColor = Resources.Colors.textColor
            s.borderStyle = .none
            s.placeholder = Resources.Texts.newListNamePlaceholder
            s.addTarget(self, action: #selector(nameTextFieldEditingChanged), for: .editingChanged)
            s.sendActions(for: .editingChanged)
        }
    }

    // Functions

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
