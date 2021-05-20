//
//  UICodeSegmentedControl.swift
//  
//
//  Created by Jezreel Barbosa on 06/05/21.
//

import UIKit

open class UICodeSegmentedControl: UISegmentedControl {

    private var observers: [UIControl.State: NSObjectProtocol] = [:]

    public func setScaledFont(for state: UIControl.State, font: (() -> UIFont)?) {
        updateTextAttribute(font?(), forKey: .font, for: state)

        if let observer = observers[state] {
            NotificationCenter.default.removeObserver(observer)
            observers.removeValue(forKey: state)
        }
        if let font = font {
            let name = UIContentSizeCategory.didChangeNotification
            let observer = NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { [weak self] _ in
                self?.updateFont(font(), for: state)
            }
            observers[state] = observer
        }
    }

    deinit {
        observers.values.forEach { observer in
            NotificationCenter.default.removeObserver(observer)
        }
    }
}

extension UIControl.State: Hashable {}

public extension UISegmentedControl {

    func updateTextAttribute<T>(_ value: T?, forKey key: NSAttributedString.Key, for state: UIControl.State) {
        guard let value = value else {
            removeTextAttribute(forKey: key, for: state)
            return
        }
        guard var attributes = titleTextAttributes(for: state) else {
            setTitleTextAttributes([key: value], for: state)
            return
        }
        attributes.updateValue(value, forKey: key)
        setTitleTextAttributes(attributes, for: state)
    }

    func updateFont(_ font: UIFont?, for state: UIControl.State) {
        updateTextAttribute(font, forKey: .font, for: state)
    }

    func removeTextAttribute(forKey key: NSAttributedString.Key, for state: UIControl.State) {
        guard var attributes = titleTextAttributes(for: state) else { return }
        attributes.removeValue(forKey: key)
        setTitleTextAttributes(attributes, for: state)
    }
}
