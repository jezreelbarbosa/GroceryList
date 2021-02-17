//
//  NewListPresenter.swift
//  MainList
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import Presentation
import Domain

public final class NewListPresenter {

    // Properties

    public var errorMessageBox = Box(String())

    private let createNewGroceryListUseCase: CreateNewGroceryListUseCaseProtocol

    private let successCompletion: VoidCompletion

    // Lifecycle

    public init(createNewGroceryListUseCase: CreateNewGroceryListUseCaseProtocol,
                successCompletion: @escaping VoidCompletion) {
        self.createNewGroceryListUseCase = createNewGroceryListUseCase
        self.successCompletion = successCompletion
    }
}

extension NewListPresenter: NewListPresenting {

    public func createNewGroceryList(model: NewGroceryListHeaderViewModel, successCompletion: VoidCompletion) {
        let request = NewGroceryListRequest(icon: model.icon, name: model.name, date: Date())
        let result = createNewGroceryListUseCase.execute(request: request)
        result.successHandler { _ in
            successCompletion()
            self.successCompletion()
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }
    }
}
