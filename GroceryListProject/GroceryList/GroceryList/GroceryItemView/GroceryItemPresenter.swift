//
//  GroceryItemPresenter.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 28/02/21.
//

import Domain

public final class GroceryItemPresenter {

    // Properties

    public var errorMessageBox: Box<String>
    public var groceryItemBox: Box<GroceryItemUpdateRequest>

    let insertGroceryItemIntoListUseCase: InsertGroceryItemIntoListUseCaseProtocol
    let successCompletion: VoidCompletion

    let item: GroceryItemModel

    // Lifecycle

    public init(insertGroceryItemIntoListUseCase: InsertGroceryItemIntoListUseCaseProtocol,
                item: GroceryItemModel, successCompletion: @escaping VoidCompletion) {
        self.insertGroceryItemIntoListUseCase = insertGroceryItemIntoListUseCase
        self.successCompletion = successCompletion
        self.item = item

        self.errorMessageBox = Box("")
        self.groceryItemBox = Box(GroceryItemUpdateRequest.from(domain: item))
    }
}

extension GroceryItemPresenter: GroceryItemPresenting {

    public func updateGroceryItem(item: GroceryItemUpdateRequest, successCompletion: () -> Void) {

        let model = GroceryItemModel(id: self.item.id, listID: self.item.listID, name: item.itemName, quantity: item.quantity,
                                     unit: GroceryItemModel.Unit(rawValue: item.unit) ?? .unit, price: item.price)
        let result = insertGroceryItemIntoListUseCase.execute(model: model)
        result.successHandler { _ in
            successCompletion()
            self.successCompletion()
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }
    }
}
