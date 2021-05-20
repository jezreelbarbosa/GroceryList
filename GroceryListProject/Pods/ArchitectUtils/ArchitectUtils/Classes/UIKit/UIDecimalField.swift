//
//  UIDecimalField.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit

open class UIDecimalField: UITextField {

    // Properties

    public final var decimal: Decimal {
        get { decimalFromString / pow(10, fractionDigits) }
        set { text = numberFormatter.string(for: newValue) }
    }

    public var maximum: Decimal = 999_999_999.999_999 {
        didSet { sendActions(for: .editingChanged) }
    }
    public var numberStyle: NumberFormatter.Style = .decimal {
        didSet { sendActions(for: .editingChanged) }
    }
    public var fractionDigits: Int = 2  {
        didSet { sendActions(for: .editingChanged) }
    }
    public var locale: Locale! = .current {
        didSet { sendActions(for: .editingChanged) }
    }
    public var isPlaceholderShownWhenValueIsZero: Bool = true {
        didSet { sendActions(for: .editingChanged) }
    }
    public var padding = UIEdgeInsets()

    private var lastValue: String?
    private var string: String { text ?? "" }
    private var numberFormatter = NumberFormatter()
    private var stringFromDecimal: String { numberFormatter.string(for: decimal) ?? "" }
    private var decimalFromString: Decimal { Decimal(string: digits) ?? 0 }
    private var digits: String { string.filter({ $0.isNumber }) }
    private var maximumFraction: Decimal { maximum / pow(10, fractionDigits)}
    private let selectionButton = UIButton()

    // Lifecycle

    public override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)

        initView()
    }

    // Override

    open override func deleteBackward() {
        super.deleteBackward()

        sendActions(for: .editingChanged)
    }

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

    @objc public func editingChanged() {
        updateNumberFormatter()
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

    private func updateNumberFormatter() {

        numberFormatter.numberStyle = numberStyle
        numberFormatter.maximumFractionDigits = fractionDigits
        numberFormatter.minimumFractionDigits = fractionDigits
        numberFormatter.locale = locale
    }

    private func initView() {
        addSubview(selectionButton)
        selectionButton.translatesAutoresizingMaskIntoConstraints = false
        selectionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        selectionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        selectionButton.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        selectionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        selectionButton.addTarget(self, action: #selector(touchSelection), for: .touchUpInside)

        keyboardType = .numberPad
        textAlignment = .right

        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        sendActions(for: .editingChanged)
    }

    @objc private func touchSelection() {
        becomeFirstResponder()
    }
}
