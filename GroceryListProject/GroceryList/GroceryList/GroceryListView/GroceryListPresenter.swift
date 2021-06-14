//
//  GroceryListPresenter.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Domain
import ArchitectUtils

public protocol GroceryListCoordinating: AnyObject {

    func showItemView(itemURI: URL?, listURI: URL, successCompletion: @escaping VoidCompletion)
    func didExit()
}

public final class GroceryListPresenter {

    // Properties

    weak var coordinator: GroceryListCoordinating?

    public var errorMessageBox: Box<String>
    public var groceryListBox: Box<GroceryListViewModel>
    public var reloadTableViewBox: Box<([IndexPath], [IndexPath])>

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
        self.reloadTableViewBox = Box(([], []))

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

    func updateList(addingRows: [IndexPath], removingRows: [IndexPath]) {
        let result = getGroceryListUseCase.execute(uri: groceryListURI)
        result.successHandler { model in
            groceryListModel = model
            groceryListBox.value = GroceryListViewModel(from: model)

            reloadTableViewBox.value = (addingRows, removingRows)
        }
        result.failureHandler { error in
            errorMessageBox.value = error.localizedDescription
        }
    }
}

extension GroceryListPresenter: GroceryListPresenting {

    public func updateList() {
        self.updateList(addingRows: [], removingRows: [])
    }

    public func deleteItem(uri: URL?, at indexPath: IndexPath) {
        guard let uri = uri else {
            errorMessageBox.value = Resources.Texts.unknowError
            return
        }
        let result = removeGroceryItemUseCase.execute(uri: uri)
        result.successHandler {
            updateList(addingRows: [], removingRows: [indexPath])
        }
        result.failureHandler { error in
            errorMessageBox.value = error.localizedDescription
        }
    }

    public func didSelectedItem(uri: URL?) {
        guard let uri = uri else {
            errorMessageBox.value = Resources.Texts.unknowError
            return
        }
        coordinator?.showItemView(itemURI: uri, listURI: groceryListURI) { [weak self] in
            self?.updateList()
        }
    }

    public func createNewItem() {
        coordinator?.showItemView(itemURI: nil, listURI: groceryListURI) { [weak self] in
            self?.updateList()
        }
    }
}
