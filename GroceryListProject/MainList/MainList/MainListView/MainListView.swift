//
//  MainListView.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import UIKit
import Stevia
import ArchitectUtils

public final class MainListView: UICodeView {

    // Properties

    let tableView = UITableView()

    // Lifecycle

    public override func initSubViews() {
        sv(
            tableView
        )
    }

    public override func initLayout() {
        tableView.fillContainer()
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = Resources.Colors.tableBackgroundColor
        }

        tableView.style { s in
            s.backgroundColor = .clear
            s.separatorStyle = .none
            s.tableFooterView = UIView()
        }
    }
}
