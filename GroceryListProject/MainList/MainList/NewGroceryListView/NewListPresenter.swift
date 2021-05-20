//
//  NewListPresenter.swift
//  MainList
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import Domain
import ArchitectUtils

public final class NewListPresenter {

    // Properties

    public var errorMessageBox = Box(String())

    private let getGroceryListUseCase: GetGroceryListUseCaseProtocol
    private let updateGroceryListUseCase: UpdateGroceryListUseCaseProtocol
    private let listURI: URL?
    private var groceryListModel: GroceryListModel?
    private let successCompletion: VoidCompletion

    // Lifecycle

    public init(getGroceryListUseCase: GetGroceryListUseCaseProtocol,
                updateGroceryListUseCase: UpdateGroceryListUseCaseProtocol,
                uri: URL?, successCompletion: @escaping VoidCompletion) {
        self.getGroceryListUseCase = getGroceryListUseCase
        self.updateGroceryListUseCase = updateGroceryListUseCase
        self.listURI = uri
        self.successCompletion = successCompletion
    }
}

extension NewListPresenter: NewListPresenting {

    public func getGroceryList() -> GroceryListHeaderInfoViewModel? {
        guard let uri = listURI,
              let response = getGroceryListUseCase.execute(uri: uri).failureHandler({ error in
                self.errorMessageBox.value = error.localizedDescription
              }).success
        else { return nil }

        groceryListModel = response
        return GroceryListHeaderInfoViewModel(response: response)
    }

    public func createNewGroceryList(model: GroceryListHeaderInfoViewModel, successCompletion: VoidCompletion) {
        let request = GroceryListModel(uri: listURI, icon: model.icon, name: model.name,
                                       date: groceryListModel?.date ?? Date(), items: groceryListModel?.items ?? [])
        let result = updateGroceryListUseCase.execute(request: request)
        result.successHandler { _ in
            successCompletion()
            self.successCompletion()
        }
        result.failureHandler { error in
            self.errorMessageBox.value = error.localizedDescription
        }
    }
}
