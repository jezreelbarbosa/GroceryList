//
//  GroceryListViewController.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import UIKit

public protocol GroceryListPresenting {

    var errorMessageBox: Box<String> { get }
    var groceryListBox: Box<GroceryListViewModel> { get }
    var reloadTableViewBox: Box<[Int]> { get }

    func updateList()
    func deleteItem(at row: Int)
    func didSelected(row: Int)
    func createNewItem()
}

public class GroceryListViewController: UICodeViewController<GroceryListPresenting> {

    // Properties

    private lazy var mainView = GroceryListView()

    private var groceryList: GroceryListViewModel = .empty

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
        mainView.tableView.register(GroceryItemTableViewCell.self)
        mainView.tableView.register(GroceryTotalFooterView.self)

        navigationItem.largeTitleDisplayMode = .never

        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonAction))
        navigationItem.rightBarButtonItem = addBarButton
    }

    private func setupPresenter() {
        presenter.errorMessageBox.bind { [unowned self] value in
            self.presentAttentionAlert(withMessage: value)
        }

        presenter.groceryListBox.bind { [unowned self] value in
            self.navigationItem.title = value.listName
            self.groceryList = value
        }
        
        presenter.reloadTableViewBox.bind { [unowned self] removedRows in
            if removedRows.isEmpty {
                DispatchQueue.main.async {
                    self.mainView.tableView.reloadData()
                }
            } else {
                self.mainView.tableView.performBatchUpdates({
                    let indexes = removedRows.map({ IndexPath(row: $0, section: 0) })
                    self.mainView.tableView.deleteRows(at: indexes, with: .fade)
                }, completion: { _ in
                    self.mainView.tableView.footerView(forSection: 0, as: GroceryTotalFooterView.self).fill(total: groceryList.totalPrice)
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
        return groceryList.items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GroceryItemTableViewCell.self)

        cell.fill(model: groceryList.items[indexPath.row])

        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GroceryItemTableViewCell.rowHeight
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelected(row: indexPath.row)
    }

    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction.deleteAction(style: .image) { [unowned self] (_, _, completion) in
            self.presenter.deleteItem(at: indexPath.row)
            completion(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    // Footer View

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(GroceryTotalFooterView.self)

        footer.fill(total: groceryList.totalPrice)

        return footer
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return GroceryTotalFooterView.rowHeight
    }
}
