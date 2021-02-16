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

    func updateList()
    func didSelected(row: Int)
    func createNewList()
}

public class MainListViewController: UIViewController {

    // Properties

    private lazy var mainView = MainListView()
    private let presenter: MainListPresenting

    private var grocerieLists: [GroceryListHeaderInfoViewModel] = []

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

        navigationItem.title = Resources.Texts.homeNavigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true

        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonAction))
        navigationItem.rightBarButtonItem = addBarButton
    }

    private func setupPresenter() {
        presenter.groceriesBox.bind { [unowned self] value in
            DispatchQueue.main.async {
                self.grocerieLists = value
                self.mainView.tableView.reloadData()
            }
        }

        presenter.errorMessageBox.bind { [unowned self] value in
            self.presentAttentionAlert(withMessage: value)
        }
    }

    // Actions

    @objc private func addBarButtonAction() {
        presenter.createNewList()
    }
}

extension MainListViewController: UITableViewDataSource, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grocerieLists.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GroceryListTableViewCell.self)

        cell.fill(model: grocerieLists[indexPath.row])
        cell.setFirstLastCellFor(row: indexPath.row, count: grocerieLists.count)

        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GroceryListTableViewCell.rowHeight
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelected(row: indexPath.row)
    }
}
