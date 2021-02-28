//
//  GroceryListViewController.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import UIKit

public protocol GroceryListPresenting {

    var errorMessageBox: Box<String> { get }
    var totalPriceBox: Box<String> { get }
    var removeRowBox: Box<Int?> { get }
    var groceryListBox: Box<GroceryListViewModel> { get }
    var reloadTableView: VoidCompletion { get set }

    func updateList()
    func deleteItem(at row: Int)
    func didSelected(row: Int)
    func createNewItem()
}

public class GroceryListViewController: UIViewController {

    // Properties

    private lazy var mainView = GroceryListView()
    private var presenter: GroceryListPresenting

    private var groceryList: GroceryListViewModel

    // Lifecycle

    public init(presenter: GroceryListPresenting) {
        self.presenter = presenter
        self.groceryList = presenter.groceryListBox.value

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

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
    }

    // Functions

    private func setupView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(GroceryItemTableViewCell.self)
        mainView.tableView.register(GroceryTotalFooterView.self)
        mainView.tableView.tableFooterView = UIView()

        navigationItem.largeTitleDisplayMode = .never

        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonAction))
        navigationItem.rightBarButtonItem = addBarButton
    }

    private func setupPresenter() {
        presenter.errorMessageBox.bind { [unowned self] value in
            self.presentAttentionAlert(withMessage: value)
        }

        presenter.totalPriceBox.bind { [unowned self] value in
            self.mainView.tableView.footerView(forSection: 0, as: GroceryTotalFooterView.self).fill(total: value)
        }

        presenter.removeRowBox.bind { [unowned self] value in
            guard let value = value else { return }

            DispatchQueue.main.async {
                self.mainView.tableView.deleteRows(at: [IndexPath(row: value, section: 0)], with: .fade)
            }
        }

        presenter.reloadTableView = { [unowned self] in
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        }

        presenter.groceryListBox.bind { [unowned self] value in
            self.navigationItem.title = value.listName
            self.groceryList = value
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

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteItem(at: indexPath.row)
        }
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
