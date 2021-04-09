//
//  GroceryListPresenter.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Domain

public protocol GroceryListCoordinating: AnyObject {

    func showItemView(itemURI: URL?, listURI: URL, successCompletion: @escaping VoidCompletion)
    func didExit()
}

public final class GroceryListPresenter {

    // Properties

    weak var coordinator: GroceryListCoordinating?

    public var errorMessageBox: Box<String>
    public var groceryListBox: Box<GroceryListViewModel>
    public let reloadTableViewBox: Box<[Int]>

    let groceryListURI: URL
    var groceryListModel: GroceryListModel

    let getGroceryListUseCase: GetGroceryListUseCaseProtocol
    let removeGroceryItemUseCase: RemoveGroceryItemUseCaseProtocol

    // Lifecycle

    public init(groceryListURI: URL, coordinator: GroceryListCoordinating,
                getGroceryListUseCase: GetGroceryListUseCaseProtocol,
                removeGroceryItemUseCase: RemoveGroceryItemUseCaseProtocol) {
        self.groceryListURI = groceryListURI
        self.coordinator = coordinator
        self.getGroceryListUseCase = getGroceryListUseCase
        self.removeGroceryItemUseCase = removeGroceryItemUseCase

        self.errorMessageBox = Box(.defaultValue)
        self.groceryListBox = Box(GroceryListViewModel.empty)
        self.reloadTableViewBox = Box([])

        if let model = getGroceryListUseCase.execute(uri: groceryListURI).success {
            self.groceryListModel = model
        } else {
            preconditionFailure()
        }
    }

    deinit {
        coordinator?.didExit()
    }

    // Functions

    func updateList(removingRows: [Int]) {
        let result = getGroceryListUseCase.execute(uri: groceryListURI)
        result.successHandler { model in
            self.groceryListModel = model
            self.groceryListBox.value = GroceryListViewModel(from: model)

            self.reloadTableViewBox.value = removingRows
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }
    }
}

extension GroceryListPresenter: GroceryListPresenting {

    public func updateList() {
        self.updateList(removingRows: [])
    }

    public func deleteItem(at row: Int) {
        guard let uri = groceryListModel.items.element(at: row)?.uri else {
            self.errorMessageBox.value = "URI Error"
            return
        }
        let result = removeGroceryItemUseCase.execute(uri: uri)
        result.successHandler { _ in
            self.updateList(removingRows: [row])
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }
    }

    public func didSelected(row: Int) {
        guard let uri = groceryListModel.items.element(at: row)?.uri else {
            self.errorMessageBox.value = "URI Error"
            return
        }
        coordinator?.showItemView(itemURI: uri, listURI: groceryListURI) {
            self.updateList()
        }
    }

    public func createNewItem() {
        coordinator?.showItemView(itemURI: nil, listURI: groceryListURI) {
            self.updateList()
        }
    }
}
