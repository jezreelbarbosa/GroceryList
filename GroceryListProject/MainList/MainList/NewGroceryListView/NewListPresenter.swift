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

    private let createNewGroceryListUseCase: CreateNewGroceryListUseCaseProtocol

    // Lifecycle

    public init(createNewGroceryListUseCase: CreateNewGroceryListUseCaseProtocol) {
        self.createNewGroceryListUseCase = createNewGroceryListUseCase
    }
}

extension NewListPresenter: NewListPresenting {

}
