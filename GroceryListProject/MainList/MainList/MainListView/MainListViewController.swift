//
//  MainListViewController.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import UIKit
import ArchitectUtils

public protocol MainListPresenting {

    var groceriesBox: Box<[GroceryListHeaderInfoViewModel]> { get }
    var errorMessageBox: Box<String> { get }
    var reloadTableViewBox: Box<[Int]> { get }

    func updateList()
    func didSelected(uri: URL?)
    func createNewList()
    func deleteItem(uri: URL?, at row: Int)
    func editItem(uri: URL?)
}

public final class MainListViewController: UIMainCodeViewController<MainListPresenting, MainListView> {

    // Properties

    private var groceriesList: [GroceryListHeaderInfoViewModel] = []

    private var isSearching: Bool = false
    private var searchingList: [GroceryListHeaderInfoViewModel] = []
    private var items: [GroceryListHeaderInfoViewModel] { isSearching ? searchingList : groceriesList }

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

        navigationItem.title = Resources.Texts.homeNavigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonAction))
        navigationItem.rightBarButtonItem = addBarButton
        insertSearchViewController(with: Resources.Texts.searchPlaceholder)
    }

    private func setupPresenter() {
        presenter.groceriesBox.bind { [unowned self] value in
            groceriesList = value
        }

        presenter.errorMessageBox.bind { [unowned self] value in
            presentAttentionAlert(message: value)
        }

        presenter.reloadTableViewBox.bind { [unowned self] removedRows in
            if removedRows.isEmpty {
                DispatchQueue.main.async {
                    mainView.tableView.reloadData()
                }
            } else {
                mainView.tableView.performBatchUpdates({
                    let indexes = removedRows.map({ IndexPath(row: $0, section: 0) })
                    mainView.tableView.deleteRows(at: indexes, with: .fade)
                }, completion: { _ in
                    mainView.tableView.reloadData()
                })
            }
        }
    }

    // Actions

    @objc private func addBarButtonAction() {
        presenter.createNewList()
    }
}

// MARK: - UITableViewDataSource

extension MainListViewController: UITableViewDataSource, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GroceryListTableViewCell.self)

        cell.fill(model: items.element(at: indexPath.row))
        cell.setFirstLastCellFor(row: indexPath.row, count: items.count)

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelected(uri: items.element(at: indexPath.row)?.uri)
    }

    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction.deleteConfirmationAction(view: self) { [unowned self] in
            presenter.deleteItem(uri: items.element(at: indexPath.row)?.uri, at: indexPath.row)
        }

        let editAction = UIContextualAction.editAction { [unowned self] in
            presenter.editItem(uri: items.element(at: indexPath.row)?.uri)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

// MARK: - UISearchResultsUpdating

extension MainListViewController: UISearchResultsUpdating {

    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text)
    }

    func filterContentForSearchText(_ searchText: String?) {
        if let searchText = searchText?.lowercased(), !searchText.isEmpty {
            isSearching = true
            searchingList = groceriesList.filterContains(searchText).prefixSorted(by: searchText)
        } else {
            isSearching = false
        }
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
        }
    }
}
