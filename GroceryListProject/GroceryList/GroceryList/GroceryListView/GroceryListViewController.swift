//
//  GroceryListViewController.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import UIKit
import Presentation

public protocol GroceryListPresenting {

    var errorMessageBox: Box<String> { get }
    var groceryListBox: Box<GroceryListViewModel> { get }
    var reloadTableViewBox: Box<[Int]> { get }

    func updateList()
    func deleteItem(uri: URL?, at row: Int)
    func didSelectedItem(uri: URL?)
    func createNewItem()
}

public class GroceryListViewController: UICodeViewController<GroceryListPresenting> {

    // Properties

    private lazy var mainView = GroceryListView()

    private var groceryList: GroceryListViewModel = .empty
    private var items: [GroceryItemViewModel] = []

    // Override

    public override func loadView() {
        self.view = mainView
    }

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
    }

    private func setupPresenter() {
        presenter.errorMessageBox.bind { [unowned self] value in
            presentAttentionAlert(message: value)
        }

        presenter.groceryListBox.bind { [unowned self] list in
            navigationItem.title = list.listName
            groceryList = list
            items = list.items
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
                    mainView.tableView.footerView(forSection: 0, as: GroceryTotalFooterView.self)?.fill(total: groceryList.totalPrice)
                })
            }
        }
    }

    // Actions

    @objc private func addBarButtonAction() {
        presenter.createNewItem()
    }
}

extension GroceryListViewController: UITableViewDataSource, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GroceryItemTableViewCell.self)

        cell.fill(model: items.element(at: indexPath.row))

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectedItem(uri: items.element(at: indexPath.row)?.uri)
    }

    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction.deleteConfirmationAction(view: self) { [unowned self] in
            presenter.deleteItem(uri: items.element(at: indexPath.row)?.uri, at: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    // Footer View

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(GroceryTotalFooterView.self)

        footer.fill(total: groceryList.totalPrice)

        return footer
    }
}
