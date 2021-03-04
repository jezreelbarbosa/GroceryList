//
//  NewListViewController.swift
//  MainList
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import UIKit

public protocol NewListPresenting {

    var errorMessageBox: Box<String> { get }

    func createNewGroceryList(model: NewGroceryListHeaderViewModel, successCompletion: () -> Void)
}

public class NewListViewController: UIViewController {

    // Properties

    private lazy var mainView = NewListView()
    private let presenter: NewListPresenting

    // Lifecycle

    public init(presenter: NewListPresenting) {
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

    // Functions

    private func setupView() {
        navigationItem.title = Resources.Texts.newListNavigationTitle
        navigationController?.navigationBar.prefersLargeTitles = false

        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarButtonAction))
        navigationItem.rightBarButtonItem = saveBarButton
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBarButtonAction))
        navigationItem.leftBarButtonItem = cancelBarButton
    }

    private func setupPresenter() {
        presenter.errorMessageBox.bind { [unowned self] value in
            self.presentAttentionAlert(withMessage: value)
        }
    }

    // Actions

    @objc private func saveBarButtonAction() {
        presenter.createNewGroceryList(model: NewGroceryListHeaderViewModel(
            icon: mainView.iconTextField.text.defaultValue,
            name: mainView.nameTextField.text.defaultValue
        )) {
            dismiss(animated: true, completion: nil)
        }
    }

    @objc private func cancelBarButtonAction() {
        dismiss(animated: true, completion: nil)
    }
}
