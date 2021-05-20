//
//  UIOptionAlert.swift
//  
//
//  Created by Jezreel Barbosa on 01/05/21.
//

import UIKit

public class UIOptionAlert {

    // Properties

    public let alert: UIAlertController
    public weak var view: UIViewController?

    // Lifecycle

    public init(title: String, message: String, view: UIViewController?) {
        self.view = view
        self.alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }

    // Functions

    @discardableResult public func addDefaultAction(title: String, handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        let action = UIAlertAction(title: title, style: .default, handler: handler)
        alert.addAction(action)
        return self
    }

    @discardableResult public func addCancelAction(title: String, handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        let action = UIAlertAction(title: title, style: .cancel, handler: handler)
        alert.addAction(action)
        return self
    }

    @discardableResult public func addDestructiveAction(title: String, handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        let action = UIAlertAction(title: title, style: .destructive, handler: handler)
        alert.addAction(action)
        return self
    }

    public func present() {
        DispatchQueue.main.async {
            self.view?.present(self.alert, animated: true)
        }
    }
}
