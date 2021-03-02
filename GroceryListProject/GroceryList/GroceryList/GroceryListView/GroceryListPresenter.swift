//
//  GroceryListPresenter.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Domain

public protocol GroceryListCoordinating: AnyObject {

    func showItemView(item: GroceryItemModel, successCompletion: @escaping VoidCompletion)
    func didExit()
}

public final class GroceryListPresenter {

    // Properties

    weak var coordinator: GroceryListCoordinating?

    public var errorMessageBox: Box<String>
    public var removeRowBox: Box<Int?>
    public var groceryListBox: Box<GroceryListViewModel>
    public var reloadTableView: VoidCompletion

    let groceryListID: UUID
    var groceryListModel: GroceryListModel?

    let getGroceryListUseCase: GetGroceryListUseCaseProtocol
    let updateGroceryListUseCase: UpdateGroceryListUseCaseProtocol

    // Lifecycle

    public init(groceryListID: UUID, coordinator: GroceryListCoordinating,
                getGroceryListUseCase: GetGroceryListUseCaseProtocol,
                updateGroceryListUseCase: UpdateGroceryListUseCaseProtocol) {
        self.groceryListID = groceryListID
        self.coordinator = coordinator
        self.getGroceryListUseCase = getGroceryListUseCase
        self.updateGroceryListUseCase = updateGroceryListUseCase

        self.errorMessageBox = Box(.defaultValue)
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
            self.groceryListModel = model
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
        guard let list = groceryListModel else { return }

        var newItems = list.items
        newItems.remove(at: row)
        let newModel = GroceryListModel(id: list.id, name: list.name, items: newItems)

        let result = updateGroceryListUseCase.execute(model: newModel)
        result.successHandler { _ in
            self.updateList(hasToReloadTableView: false)
            self.removeRowBox.value = row
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }
    }

    public func didSelected(row: Int) {
        guard let list = groceryListModel else { return }

        coordinator?.showItemView(item: list.items[row]) {
            self.updateList(hasToReloadTableView: true)
        }
    }

    public func createNewItem() {
        guard let list = groceryListModel else { return }

        let item = GroceryItemModel(id: UUID(), listID: list.id, name: "", quantity: 0, unit: .unit, price: 0)
        coordinator?.showItemView(item: item) {
            self.updateList(hasToReloadTableView: true)
        }

//        guard let list = groceryListModel else { return }
//
//        let newItem = GroceryItemModel(name: "Macarrão", quantity: 1, unit: .unit, price: 2.00)
//        let newModel = GroceryListModel(id: list.id, name: list.name, items: list.items + [newItem])
//
//        let result = updateGroceryListUseCase.execute(model: newModel)
//        result.successHandler { _ in
//            self.updateList(hasToReloadTableView: true)
//        }
//        result.failureHandler { error in
//            self.errorMessageBox.value = error.localizedDescription
//        }
    }
}
