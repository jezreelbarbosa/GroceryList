//
//  GroceryListView.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 27/02/21.
//

import UIKit
import Stevia
import ArchitectUtils

final class GroceryListView: UICodeView {

    // Properties

    let tableView = UITableView()
    let effectView = UIVisualEffectView()

    // Lifecycle

    public override func initSubViews() {
        sv(
            tableView,
            effectView
        )
    }

    public override func initLayout() {
        tableView.fillContainer()
        effectView.fillHorizontally().Top == safeAreaLayoutGuide.Bottom
        effectView.Bottom == Bottom
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

        effectView.style { s in
            s.effect = UIBlurEffect(style: .regular)
        }
    }
}
