//
//  UITableView+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import UIKit

public extension UITableView {

    func register<T: UITableViewCell & ReuseIdentifiable>(_ cellClass: T.Type) {
        register(cellClass.self, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell & ReuseIdentifiable>(_ cellClass: T.Type) -> T {
        if let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as? T {
            return cell
        }
        register(cellClass)
        if let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as? T {
            return cell
        }
        preconditionFailure("Reusable cell is nil: \(cellClass)")
    }

    func register<T: UITableViewHeaderFooterView & ReuseIdentifiable>(_ headerFooterCellClass: T.Type) {
        register(headerFooterCellClass.self, forHeaderFooterViewReuseIdentifier: headerFooterCellClass.reuseIdentifier)
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView & ReuseIdentifiable>(_ cellClass: T.Type) -> T {
        if let cell = dequeueReusableHeaderFooterView(withIdentifier: cellClass.reuseIdentifier) as? T {
            return cell
        }
        register(cellClass)
        if let cell = dequeueReusableHeaderFooterView(withIdentifier: cellClass.reuseIdentifier) as? T {
            return cell
        }
        preconditionFailure("Reusable cell is nil: \(cellClass)")
    }
}
