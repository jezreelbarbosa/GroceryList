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

    let createNewGroceryListUseCase: CreateNewGroceryListUseCaseProtocol

    // Lifecycle

    public init(groceryListID: UUID, coordinator: GroceryListCoordinating,
                createNewGroceryListUseCase: CreateNewGroceryListUseCaseProtocol) {
        self.groceryListID = groceryListID
        self.coordinator = coordinator
        self.createNewGroceryListUseCase = createNewGroceryListUseCase

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
        self.groceryListBox.value = GroceryListViewModel(from: GroceryListModel(id: UUID(), name: "Grocery", items: [
            GroceryItemModel(name: "Macarrão", quantity: 2, unit: .unit, price: 2.85),
            GroceryItemModel(name: "Macarrão", quantity: 0, unit: .unit, price: 2.85),
            GroceryItemModel(name: "Macarrão", quantity: 2, unit: .unit, price: 0),
            GroceryItemModel(name: "Macarrão", quantity: 2.5, unit: .kilogram, price: 2.85),
            GroceryItemModel(name: "Macarrão", quantity: 0.200, unit: .hundredGrams, price: 2.85),
            GroceryItemModel(name: "Macarrão", quantity: 2, unit: .liter, price: 2.85),
            GroceryItemModel(name: "Macarrão", quantity: 2, unit: .unit, price: 2.85),
            GroceryItemModel(name: "Macarrão", quantity: 2, unit: .unit, price: 2.85),
            GroceryItemModel(name: "Macarrão", quantity: 2, unit: .unit, price: 2.85),
            GroceryItemModel(name: "Macarrão", quantity: 2, unit: .unit, price: 2.85),
            GroceryItemModel(name: "Macarrão", quantity: 2, unit: .unit, price: 2.85),
            GroceryItemModel(name: "Macarrão", quantity: 2, unit: .unit, price: 2.85),
            GroceryItemModel(name: "Macarrão", quantity: 2, unit: .unit, price: 2.85),
            GroceryItemModel(name: "Macarrão", quantity: 2, unit: .unit, price: 2.85)
        ]))

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
