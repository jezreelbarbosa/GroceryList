//
//  UIDecimalField.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import UIKit

class UIDecimalField: UITextField {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    var decimal: Decimal {
        return decimalFromString / pow(10, numberFormatter.maximumFractionDigits)
    }
    var maximum: Decimal = 999_999_999.999999
    
    var locale: Locale = .current {
        didSet {
            numberFormatter.locale = locale
            sendActions(for: .editingChanged)
        }
    }
    var fractionDigits: Int = 2 {
        didSet {
            numberFormatter.maximumFractionDigits = fractionDigits
            numberFormatter.minimumFractionDigits = fractionDigits
            sendActions(for: .editingChanged)
        }
    }
    var numberStyle: NumberFormatter.Style = .decimal {
        didSet {
            numberFormatter.numberStyle = numberStyle
            sendActions(for: .editingChanged)
        }
    }
    
    // Public Methods
    
    @objc func editingChanged() {
        guard decimal <= maximumFraction else {
            text = lastValue
            return
        }
        text = stringFromDecimal
        lastValue = text
    }
    
    // Initialisation/Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    // Override Methods
    
    override func willMove(toSuperview newSuperview: UIView?) {
        numberFormatter.locale = locale
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .right
        sendActions(for: .editingChanged)
    }
    
    override func deleteBackward() {
        let last = digits.dropLast()
        text = String(last)
        sendActions(for: .editingChanged)
    }
    
    // Private Types
    // Private Properties
    
    private var string: String {
        return text ?? ""
    }
    private var lastValue: String?
    private let numberFormatter = NumberFormatter()
    
    private var stringFromDecimal: String {
        return numberFormatter.string(for: decimal) ?? ""
    }
    private var decimalFromString: Decimal {
        return Decimal(string: digits) ?? 0
    }
    private var digits: String {
        return string.filter({ $0.isWholeNumber })
    }
    private var maximumFraction: Decimal {
        return maximum / pow(10, numberFormatter.maximumFractionDigits)
    }
    
    // Private Methods
    
    private func initView() {
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
    }
}
