//
//  Box.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Foundation

public final class Box<T> {
    // Static Properties
    // Static Methods
    // Public Types

    public typealias Listener = (T) -> Void

    // Public Properties

    public var value: T {
        didSet { fire() }
    }

    // Public Methods

    public func bind(listener: Listener?) {
        self.listener = listener
    }

    public func fire() {
        listener?(value)
    }

    public func bindAndFire(listener: Listener?) {
        bind(listener: listener)
        fire()
    }

    // Initialization/Lifecycle Methods

    public init(_ value: T) {
        self.value = value
    }

    // Override Methods
    // Private Types
    // Private Properties

    private var listener: Listener?
    
    // Private Methods
}
