//
//  NewListViewController.swift
//  MainList
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import Presentation
import UIKit

public protocol NewListPresenting {

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
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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

    // Actions

    @objc private func saveBarButtonAction() {

    }

    @objc private func cancelBarButtonAction() {

    }
}
