//
//  MainListViewController.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import Presentation
import UIKit

public protocol MainListPresenting {

    var groceriesBox: Box<[GroceryListHeaderInfoViewModel]> { get }
    var errorMessageBox: Box<String> { get }
    var removeRowBox: Box<Int?> { get }

    var reloadTableView: VoidCompletion { get set }

    func updateList()
    func didSelected(row: Int)
    func createNewList()
    func deleteItem(at row: Int)
}

public class MainListViewController: UIViewController {

    // Properties

    private lazy var mainView = MainListView()
    private var presenter: MainListPresenting

    private var groceriesList: [GroceryListHeaderInfoViewModel] = []

    // Lifecycle

    public init(presenter: MainListPresenting) {
        self.presenter = presenter
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
        mainView.tableView.selectRow(at: nil, animated: animated, scrollPosition: .none)
    }

    // Functions

    private func setupView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(GroceryListTableViewCell.self)
        mainView.tableView.tableFooterView = UIView()

        navigationItem.title = Resources.Texts.homeNavigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true

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

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteItem(at: indexPath.row)
        }
    }
}
