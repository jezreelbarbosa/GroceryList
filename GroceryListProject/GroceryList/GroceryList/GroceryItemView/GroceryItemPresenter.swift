//
//  GroceryItemPresenter.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 28/02/21.
//

import Domain

public final class GroceryItemPresenter {

    // Properties

    public var errorMessageBox = Box(String())

    let createNewGroceryListUseCase: CreateNewGroceryListUseCaseProtocol
    let item: GroceryItemModel?
    let successCompletion: VoidCompletion

    // Lifecycle

    public init(createNewGroceryListUseCase: CreateNewGroceryListUseCaseProtocol,
                item: GroceryItemModel?,
                successCompletion: @escaping VoidCompletion) {
        self.createNewGroceryListUseCase = createNewGroceryListUseCase
        self.item = item
        self.successCompletion = successCompletion
    }
}

extension GroceryItemPresenter: GroceryItemPresenting {

}
