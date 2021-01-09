//
//  MainListViewController.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import Presentation
import UIKit

public protocol MainListPresenting {

    var groceriesBox: Box<[String]> { get }
    func updateList()

    func didSelected(groceryList: String)
}

public class MainListViewController: UIViewController {

    // Properties

    private lazy var mainView = MainListView()
    private let presenter: MainListPresenting

    private var grocerieLists: [String] = []

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
        presenter.updateList()
    }

    // Functions

    private func setupPresenter() {
        presenter.groceriesBox.bind { [unowned self] value in
            DispatchQueue.main.async {
                self.grocerieLists = value
                self.mainView.tableView.reloadData()
            }
        }
    }

    private func setupView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(GroceryListTableViewCell.self)
    }
}

extension MainListViewController: UITableViewDataSource, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grocerieLists.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GroceryListTableViewCell.self)

        cell.fill(title: grocerieLists[indexPath.row])

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelected(groceryList: grocerieLists[indexPath.row])
    }
}
