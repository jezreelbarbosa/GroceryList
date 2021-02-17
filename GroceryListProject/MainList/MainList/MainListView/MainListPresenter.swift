//
//  MainListPresenter.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import Presentation
import Domain

public protocol MainListCoordinating: AnyObject {

    func showNewListView(successCompletion: @escaping VoidCompletion)
}

public final class MainListPresenter {

    // Properties

    weak var coordinator: MainListCoordinating?

    public let groceriesBox = Box([GroceryListHeaderInfoViewModel]())
    public var errorMessageBox = Box(String())

    private let getGroceryMainListUseCase: GetGroceryMainListUseCaseProtocol
    private let createNewGroceryListUseCase: CreateNewGroceryListUseCaseProtocol

    // Lifecycle

    public init(coordinator: MainListCoordinating, getGroceryMainListUseCase: GetGroceryMainListUseCaseProtocol,
                createNewGroceryListUseCase: CreateNewGroceryListUseCaseProtocol) {
        self.coordinator = coordinator
        self.getGroceryMainListUseCase = getGroceryMainListUseCase
        self.createNewGroceryListUseCase = createNewGroceryListUseCase
    }
}

extension MainListPresenter: MainListPresenting {

    public func updateList() {
        let result = getGroceryMainListUseCase.execute()
        result.successHandler { response in
            self.groceriesBox.value = response.map({ GroceryListHeaderInfoViewModel(response: $0) })
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }
    }

    public func didSelected(row: Int) {
        // TODO: call coordinator
        debugPrint(row)
    }

    public func createNewList() {
        coordinator?.showNewListView { [weak self] in
            self?.updateList()
        }
    }
}
