//
//  UITableView+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import UIKit

public extension UITableView {

    func register<T: UITableViewCell & ReuseIdentifiable>(_ cellClass: T.Type) {
        self.register(cellClass.self, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell & ReuseIdentifiable>(_ reusableCell: T.Type) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: reusableCell.reuseIdentifier) as? T else {
            preconditionFailure("Reusable cell is nil: \(T.self)")
        }
        return cell
    }

    func register<T: UITableViewHeaderFooterView & ReuseIdentifiable>(_ headerFooterCellClass: T.Type) {
        self.register(headerFooterCellClass.self, forHeaderFooterViewReuseIdentifier: headerFooterCellClass.reuseIdentifier)
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView & ReuseIdentifiable>(_ reusableCell: T.Type) -> T {
        guard let cell = self.dequeueReusableHeaderFooterView(withIdentifier: reusableCell.reuseIdentifier) as? T else {
            preconditionFailure("Reusable cell is nil: \(T.self)")
        }
        return cell
    }

    func footerView<T: UITableViewHeaderFooterView>(forSection section: Int, as reusableCell: T.Type) -> T {
        guard let cell = self.footerView(forSection: section) as? T else {
            preconditionFailure("Footer View is nil: \(T.self)")
        }
        return cell
    }

    func headerView<T: UITableViewHeaderFooterView>(forSection section: Int, as reusableCell: T.Type) -> T {
        guard let cell = self.headerView(forSection: section) as? T else {
            preconditionFailure("Header View is nil: \(T.self)")
        }
        return cell
    }
}
