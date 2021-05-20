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
    public var characterLimit = Int.max

    private var isCharacterLimited = false
    private var lastText = ""
    private var string: String { text ?? "" }

    // Lifecycle

    public override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureView()
    }

    // Override

    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // Functions

    public func setupCharacterLimit(limit: Int?) {
        if let limit = limit {
            characterLimit = limit
            isCharacterLimited = true
        } else {
            characterLimit = .max
            isCharacterLimited = false
        }
    }

    @discardableResult
    public func setLimited(text aText: String) -> Bool {
        guard isCharacterLimited, aText.count >= characterLimit else { return false }

        lastText = aText
        self.text = lastText
        return true
    }

    @objc public func editingChanged() {
        updateCharacterLimitation()
    }

    // Private Functions

    private func updateCharacterLimitation() {
        if isCharacterLimited, string.count > characterLimit {
            text = lastText
        } else {
            lastText = string
        }
    }

    private func configureView() {
        adjustsFontForContentSizeCategory = true
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
}
