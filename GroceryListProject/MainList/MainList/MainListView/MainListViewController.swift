//
//  MainListViewController.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import UIKit

public protocol MainListPresenting {

    var groceriesBox: Box<[GroceryListHeaderInfoViewModel]> { get }
    var errorMessageBox: Box<String> { get }
    var reloadTableViewBox: Box<[Int]> { get }

    func updateList()
    func didSelected(row: Int)
    func createNewList()
    func deleteItem(at row: Int)
}

public final class MainListViewController: UICodeViewController<MainListPresenting> {

    // Properties

    private lazy var mainView = MainListView()

    private var groceriesList: [GroceryListHeaderInfoViewModel] = []

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
        mainView.tableView.register(GroceryListTableViewCell.self)

        navigationItem.title = Resources.Texts.homeNavigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonAction))
        navigationItem.rightBarButtonItem = addBarButton
    }

    private func setupPresenter() {
        presenter.groceriesBox.bind { [unowned self] value in
            self.groceriesList = value
        }

        presenter.errorMessageBox.bind { [unowned self] value in
            self.presentAttentionAlert(withMessage: value)
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
                    self.mainView.tableView.reloadData()
                })
            }
        }
    }

    // Actions

    @objc private func addBarButtonAction() {
        presenter.createNewList()
    }
}

extension MainListViewController: UITableViewDataSource, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceriesList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GroceryListTableViewCell.self)

        cell.fill(model: groceriesList[indexPath.row])
        cell.setFirstLastCellFor(row: indexPath.row, count: groceriesList.count)

        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GroceryListTableViewCell.rowHeight
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelected(row: indexPath.row)
    }

    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction.deleteAction(style: .image) { [unowned self] (_, _, completion) in
            self.presenter.deleteItem(at: indexPath.row)
            completion(true)
        }

        let editAction = UIContextualAction.editAction(style: .image) { (_, _, completion) in
            // TODO: presenter to edit screen
            completion(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
