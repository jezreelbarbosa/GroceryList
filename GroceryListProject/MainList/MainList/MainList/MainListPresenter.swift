//
//  MainListPresenter.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import Presentation

public protocol MainListCoordinating: AnyObject {

}

public final class MainListPresenter {

    // Properties

    weak var coordinator: MainListCoordinating?

    public let groceriesBox: Box<[String]> = Box([])

    // Lifecycle

    public init(coordinator: MainListCoordinating) {
        self.coordinator = coordinator
    }
}

extension MainListPresenter: MainListPresenting {

    public func updateList() {
        // call use case to update
        groceriesBox.value = ["List 1", "List 2"]
    }

    public func didSelected(groceryList: String) {
        debugPrint(groceryList)
    }
}
