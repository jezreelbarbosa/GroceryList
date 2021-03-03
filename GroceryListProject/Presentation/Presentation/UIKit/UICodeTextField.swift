//
//  UICodeTextField.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 17/02/21.
//

import UIKit

public class UICodeTextField: UITextField {

    // Properties

    public var padding = UIEdgeInsets()
    public var caracterLimit = Int.max

    // Override

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // Functions

    public func setupCaracterLimit(limit: Int) {
        self.smartInsertDeleteType = .no
        self.delegate = self
        self.caracterLimit = limit
    }
}

extension UICodeTextField: UITextFieldDelegate {

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText)
        else { return false }

        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count

        return count <= caracterLimit
    }
}
