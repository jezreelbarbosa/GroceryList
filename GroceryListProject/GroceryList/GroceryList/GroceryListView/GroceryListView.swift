//
//  GroceryListView.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import Stevia

final class GroceryListView: UICodeView {

    // Properties

    let tableView = UITableView()

    // Lifecycle

    public override func initSubViews() {
        sv(
            tableView
        )
    }

    public override func initLayout() {
        tableView.Top == safeAreaLayoutGuide.Top
        tableView.Bottom == safeAreaLayoutGuide.Bottom
        tableView.Leading == safeAreaLayoutGuide.Leading
        tableView.Trailing == safeAreaLayoutGuide.Trailing

        layoutIfNeeded()
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = Resources.Colors.tableBackgroundColor
        }

        tableView.style { s in
            s.backgroundColor = .clear
            s.separatorStyle = .singleLine
        }
    }

    // Functions

}
