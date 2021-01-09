//
//  GroceryListTableViewCell.swift
//  MainList
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import Presentation
import Stevia

public final class GroceryListTableViewCell: UICodeTableViewCell {

    // Static properties

    public override class var reuseIdentifier: String { "GroceryListTableViewCell" }

    // Properties

    let titleLabel = UILabel()

    // Lifecycle

    public override func initSubViews() {
        sv(
            titleLabel
        )
    }

    public override func initLayout() {
        titleLabel.leading(16).top(16)

        layoutIfNeeded()
    }

    public override func initStyle() {
        style { s in
            s.selectionStyle = .none
        }
    }

    // Functions

    func fill(title: String) {
        titleLabel.text = title
    }
}
