//
//  Box.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 03/06/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import Foundation

final class Box<T> {
    // Static Properties
    // Static Methods
    // Public Types
    
    typealias Listener = (T) -> Void
    
    // Public Properties
    
    var listener: Listener?
    
    var value: T {
        didSet{
            listener?(value)
        }
    }
    
    // Public Methods
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    func fire() {
        listener?(value)
    }
    
    // Initialisation/Lifecycle Methods
    
    init(_ value: T) {
        self.value = value
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    // Private Methods
}
