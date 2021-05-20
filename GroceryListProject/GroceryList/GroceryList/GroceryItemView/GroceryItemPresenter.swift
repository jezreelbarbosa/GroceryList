//
//  GroceryItemPresenter.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 28/02/21.
//

import Domain
import ArchitectUtils

public final class GroceryItemPresenter {

    // Properties

    public var errorMessageBox: Box<String>
    public var groceryItemBox: Box<GroceryItemUpdateRequest>

    let insertGroceryItemIntoListUseCase: InsertGroceryItemIntoListUseCaseProtocol
    let getGroceryItemUseCase: GetGroceryItemUseCaseProtocol
    let successCompletion: VoidCompletion

    let listURI: URL
    let itemURI: URL?

    // Lifecycle

    public init(insertGroceryItemIntoListUseCase: InsertGroceryItemIntoListUseCaseProtocol,
                getGroceryItemUseCase: GetGroceryItemUseCaseProtocol,
                itemURI: URL?, listURI: URL, successCompletion: @escaping VoidCompletion) {
        self.insertGroceryItemIntoListUseCase = insertGroceryItemIntoListUseCase
        self.getGroceryItemUseCase = getGroceryItemUseCase
        self.successCompletion = successCompletion
        self.listURI = listURI
        self.itemURI = itemURI

        self.errorMessageBox = Box("")

        if let itemURI = itemURI, let groceryItem = getGroceryItemUseCase.execute(uri: itemURI).success {
            self.groceryItemBox = Box(GroceryItemUpdateRequest.from(domain: groceryItem))
        } else {
            self.groceryItemBox = Box(GroceryItemUpdateRequest.empty)
        }
    }
}

extension GroceryItemPresenter: GroceryItemPresenting {

    public func updateGroceryItem(item: GroceryItemUpdateRequest, successCompletion: () -> Void) {
        let model = GroceryItemModel(uri: itemURI, name: item.itemName, quantity: item.quantity,
                                     unit: GroceryItemModel.Unit(rawValue: item.unit) ?? .unit,
                                     price: item.price, date: item.date)
        let result = insertGroceryItemIntoListUseCase.execute(model: model, listURI: listURI)
        result.successHandler { _ in
            successCompletion()
            self.successCompletion()
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }
    }
}
