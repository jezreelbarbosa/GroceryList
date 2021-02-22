//
//  UICodeTextField.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 17/02/21.
//

import UIKit
import InputMask

public class UICodeTextField: UITextField {

    // Properties

    public var padding = UIEdgeInsets()
    public var caracterLimit = Int.max

    private var maskObject: MaskedTextFieldDelegate?

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

extension UICodeTextField: MaskedTextFieldDelegateListener {

    public func setupMask(_ primaryMaskFormat: Mask.Formats, affineFormats: [Mask.Formats] = [], delegate: NSObject? = nil,
                          stratagy: AffinityCalculationStrategy = .extractedValueCapacity) {
        let maskObject = MaskedTextFieldDelegate()
        self.maskObject = maskObject
        self.delegate = maskObject
        maskObject.affinityCalculationStrategy = stratagy
        maskObject.autocompleteOnFocus = true
        maskObject.primaryMaskFormat = primaryMaskFormat.format
        maskObject.affineFormats = affineFormats.map({ $0.format })
        maskObject.delegate = delegate
    }

    public func set(text: String) {
        guard let maskObject = maskObject else {
            self.text = text
            return
        }
        maskObject.put(text: text, into: self)
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
