//
//  GroceryListView.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import UIKit
import Stevia
import ArchitectUtils

public final class GroceryListView: UICodeView {

    // Properties

    let tableView = UITableView()
    let footerView = GroceryTotalFooterView()

    // Lifecycle

    public override func initSubViews() {
        sv(
            tableView,
            footerView
        )
    }

    public override func initLayout() {
        tableView.top(0).fillHorizontally().Bottom == footerView.Top
        footerView.fillHorizontally().Bottom == Bottom
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = Resources.Colors.tableBackgroundColor
        }

        tableView.style { s in
            s.backgroundColor = .clear
            s.separatorStyle = .singleLine
            s.tableFooterView = UIView()
        }
    }
}
