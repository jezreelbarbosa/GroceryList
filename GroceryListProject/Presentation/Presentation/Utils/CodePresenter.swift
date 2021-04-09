//
//  CodePresenter.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 08/04/21.
//

public protocol Presenting {

    func attach(view: AnyObject)
}

open class CodePresenter<T: AnyObject>: Presenting {

    public weak var view: T?

    public func attach(view: AnyObject) {
        self.view = view as? T
    }
}
