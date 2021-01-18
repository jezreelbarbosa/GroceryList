//
//  MainListView.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import Presentation
import Stevia

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
        tableView.Top == safeAreaLayoutGuide.Top
        tableView.Bottom == safeAreaLayoutGuide.Bottom
        tableView.Leading == safeAreaLayoutGuide.Leading
        tableView.Trailing == safeAreaLayoutGuide.Trailing

        layoutIfNeeded()
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = .cyan
        }

        tableView.style { s in
            s.backgroundColor = Resources.Colors.backgroundColor
            s.separatorStyle = .none
        }
    }

    // Functions

}
