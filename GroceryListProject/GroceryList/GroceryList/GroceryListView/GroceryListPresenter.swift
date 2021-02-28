//
//  GroceryListPresenter.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Domain

public protocol GroceryListCoordinating: AnyObject {

    func showItemView(successCompletion: @escaping VoidCompletion)
    func didExit()
}

public final class GroceryListPresenter {

    // Properties

    weak var coordinator: GroceryListCoordinating?

    public var errorMessageBox: Box<String>
    public var totalPriceBox: Box<String>
    public var removeRowBox: Box<Int?>
    public var groceryListBox: Box<GroceryListViewModel>
    public var reloadTableView: VoidCompletion

    let groceryListID: UUID

    let getGroceryListUseCase: GetGroceryListUseCaseProtocol

    // Lifecycle

    public init(groceryListID: UUID, coordinator: GroceryListCoordinating,
                getGroceryListUseCase: GetGroceryListUseCaseProtocol) {
        self.groceryListID = groceryListID
        self.coordinator = coordinator
        self.getGroceryListUseCase = getGroceryListUseCase

        self.errorMessageBox = Box(.defaultValue)
        self.totalPriceBox = Box(.defaultValue)
        self.removeRowBox = Box(nil)
        self.groceryListBox = Box(GroceryListViewModel.empty)
        self.reloadTableView = {}
    }

    deinit {
        coordinator?.didExit()
    }

    // Functions

    func updateList(hasToReloadTableView: Bool) {
        let result = getGroceryListUseCase.execute(id: groceryListID)
        result.successHandler { model in
            self.groceryListBox.value = GroceryListViewModel(from: model)
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }

        if hasToReloadTableView {
            self.reloadTableView()
        }
    }
}

extension GroceryListPresenter: GroceryListPresenting {

    public func updateList() {
        self.updateList(hasToReloadTableView: true)
    }

    public func deleteItem(at row: Int) {

    }

    public func didSelected(row: Int) {

    }

    public func createNewItem() {

    }
}
