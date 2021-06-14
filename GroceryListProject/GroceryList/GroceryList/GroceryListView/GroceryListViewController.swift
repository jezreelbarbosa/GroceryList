//
//  GroceryListViewController.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import UIKit
import ArchitectUtils

public protocol GroceryListPresenting {

    var errorMessageBox: Box<String> { get }
    var groceryListBox: Box<GroceryListViewModel> { get }
    var reloadTableViewBox: Box<([IndexPath], [IndexPath])> { get }

    func updateList()
    func deleteItem(uri: URL?, at indexPath: IndexPath)
    func didSelectedItem(uri: URL?)
    func createNewItem()
}

public class GroceryListViewController: UIMainCodeViewController<GroceryListPresenting, GroceryListView> {

    // Properties

    private var groceryList: GroceryListViewModel = .empty

    private var isSearching: Bool = false
    private var searchingList: [GroceryItemViewModel] = []
    private var items: [GroceryItemViewModel] { isSearching ? searchingList : groceryList.items }

    // Override

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupPresenter()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.updateList()
        mainView.tableView.selectRow(at: nil, animated: animated, scrollPosition: .none)
    }

    // Functions

    private func setupView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self

        navigationItem.largeTitleDisplayMode = .never

        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonAction))
        navigationItem.rightBarButtonItem = addBarButton
        insertSearchViewController(with: Resources.Texts.searchPlaceholder)
    }

    private func setupPresenter() {
        presenter.errorMessageBox.bind { [unowned self] message in
            presentAttentionAlert(message: message)
        }

        presenter.groceryListBox.bind { [unowned self] list in
            navigationItem.title = list.listName
            groceryList = list
        }

        presenter.reloadTableViewBox.bind { [unowned self] addedRows, removedRows in
            mainView.footerView.fill(total: groceryList.totalPrice)

            guard !addedRows.isEmpty || !removedRows.isEmpty else {
                DispatchQueue.main.async {
                    mainView.tableView.reloadData()
                }
                return
            }
            mainView.tableView.performBatchUpdates {
                mainView.tableView.insertRows(at: addedRows, with: .fade)
                mainView.tableView.deleteRows(at: removedRows, with: .fade)
            }
        }
    }

    // Actions

    @objc private func addBarButtonAction() {
        presenter.createNewItem()
    }
}

// MARK: - UITableViewDataSource

extension GroceryListViewController: UITableViewDataSource, UITableViewDelegate {

    private enum Sections: Int, CaseIterable {

        case unchecked = 0
        case checked = 1
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section) {
        case .unchecked:
            return items.count
        case .checked:
            return 0
        case .none:
            return 0
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GroceryItemTableViewCell.self)

        let section = Sections(rawValue: indexPath.section)
        section.doOn(.unchecked) {
            cell.fill(model: items.element(at: indexPath.row))
        }
        section.doOn(.checked) {
            cell.fill(model: items.element(at: indexPath.row))
        }

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = Sections(rawValue: indexPath.section)
        section.doOn(.unchecked) {
            let uri = items.element(at: indexPath.row)?.uri
            presenter.didSelectedItem(uri: uri)
        }
        section.doOn(.checked) {
            let uri = items.element(at: indexPath.row)?.uri
            presenter.didSelectedItem(uri: uri)
        }
    }

    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction.deleteConfirmationAction(view: self) { [unowned self] in
            let uri = items.element(at: indexPath.row)?.uri
            presenter.deleteItem(uri: uri, at: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = items[indexPath.row]
        let checkAction = UIContextualAction.checkAction(isChecked: false) {
            debugPrint(item.name)
        }
        return UISwipeActionsConfiguration(actions: [checkAction])
    }
}

// MARK: - UISearchResultsUpdating

extension GroceryListViewController: UISearchResultsUpdating {

    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text)
    }

    func filterContentForSearchText(_ searchText: String?) {
        if let searchText = searchText?.lowercased(), !searchText.isEmpty {
            isSearching = true
            searchingList = groceryList.items.filterContains(searchText).prefixSorted(by: searchText)
        } else {
            isSearching = false
        }
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
        }
    }
}
