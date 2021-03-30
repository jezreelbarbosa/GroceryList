//
//  Box.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

public final class Box<T> {

    public typealias Listener = (T) -> Void

    // Properties

    public var value: T {
        didSet { fire() }
    }

    private var listener: Listener?

    // Lifecycle

    public init(_ value: T) {
        self.value = value
    }

    // Functions

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
}
