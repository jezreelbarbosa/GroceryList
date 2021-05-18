//
//  NewListViewController.swift
//  MainList
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import UIKit
import Presentation

public protocol NewListPresenting {

    var errorMessageBox: Box<String> { get }

    func getGroceryList() -> GroceryListHeaderInfoViewModel?
    func createNewGroceryList(model: GroceryListHeaderInfoViewModel, successCompletion: VoidCompletion)
}

public class NewListViewController: UICodeViewController<NewListPresenting> {

    // Properties

    private lazy var mainView = NewListView()

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

        if let list = presenter.getGroceryList() {
            mainView.set(model: list)
            title = Resources.Texts.editListNavigationTitle
        } else {
            title = Resources.Texts.newListNavigationTitle
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        mainView.nameTextField.becomeFirstResponder()
        mainView.nameTextField.selectAll(nil)
    }

    // Functions

    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = false

        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarButtonAction))
        navigationItem.rightBarButtonItem = saveBarButton
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBarButtonAction))
        navigationItem.leftBarButtonItem = cancelBarButton
    }

    private func setupPresenter() {
        presenter.errorMessageBox.bind { [unowned self] value in
            presentAttentionAlert(message: value)
        }
    }

    // Actions

    @objc private func saveBarButtonAction() {
        presenter.createNewGroceryList(model: mainView.getModel()) {
            dismiss(animated: true, completion: nil)
        }
    }

    @objc private func cancelBarButtonAction() {
        dismiss(animated: true, completion: nil)
    }
}
