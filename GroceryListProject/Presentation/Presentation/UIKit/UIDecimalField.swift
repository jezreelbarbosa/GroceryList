//
//  UIDecimalField.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit

open class UIDecimalField: UITextField {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties

    final var decimal: Decimal { decimalFromString / pow(10, numberFormatter.maximumFractionDigits) }

    final var maximum: Decimal = 999_999_999.999999

    final var numberFormatter = NumberFormatter() {
        didSet { sendActions(for: .editingChanged) }
    }

    var isPlaceholderShownWhenValueIsZero: Bool = true {
        didSet { sendActions(for: .editingChanged) }
    }

    // Public Methods

    @objc func editingChanged() {
        guard decimal <= maximumFraction else {
            text = lastValue
            return
        }
        if isPlaceholderShownWhenValueIsZero && decimal == 0 {
            text = nil
            placeholder = stringFromDecimal
        } else {
            text = stringFromDecimal
            lastValue = text
        }
    }

    // Initialization/Lifecycle Methods

    public override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)

        initView()
    }

    // Override Methods

    open override func deleteBackward() {
        super.deleteBackward()

        sendActions(for: .editingChanged)
    }

    // Private Types
    // Private Properties

    private var lastValue: String?

    private var string: String { text ?? "" }
    private var stringFromDecimal: String { numberFormatter.string(for: decimal) ?? "" }
    private var decimalFromString: Decimal { Decimal(string: digits) ?? 0 }
    private var digits: String { string.filter({ $0.isWholeNumber }) }
    private var maximumFraction: Decimal { maximum / pow(10, numberFormatter.maximumFractionDigits)}

    private let selectionButton = UIButton()

    // Private Methods

    private func initView() {
        addSubview(selectionButton)
        selectionButton.translatesAutoresizingMaskIntoConstraints = false
        selectionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        selectionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        selectionButton.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        selectionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        selectionButton.addTarget(self, action: #selector(touchSelection), for: .touchUpInside)

        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = .current
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .right
        sendActions(for: .editingChanged)
    }

    @objc private func touchSelection() {
        becomeFirstResponder()
    }
}
