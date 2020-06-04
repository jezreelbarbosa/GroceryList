//
//  GroceryListView.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import Stevia

final class GroceryListView: UIView {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    let tableView = UITableView()
    
    let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    
    // Public Methods
    
    func customizeNavigationBar(_ viewController: UIViewController) {
        viewController.navigationItem.title = "GroceryListView_navigationItem_Title".localized
        viewController.navigationController?.view.backgroundColor = Colors.GroceryListScene.background
        viewController.navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    // Initialisation/Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    // Private Methods
    
    private func renderSuperView() {
        sv(
            tableView
        )
    }
    
    private func renderLayout() {
        tableView.Top == safeAreaLayoutGuide.Top
        tableView.Left == safeAreaLayoutGuide.Left
        tableView.Right == safeAreaLayoutGuide.Right
        tableView.Bottom == safeAreaLayoutGuide.Bottom
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.backgroundColor = Colors.GroceryListScene.background
        }
        tableView.style { (s) in
            s.separatorStyle = .singleLine
        }
    }
}
