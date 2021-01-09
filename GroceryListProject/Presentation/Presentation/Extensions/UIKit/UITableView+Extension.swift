//
//  UITableView+Extension.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 09/01/21.
//

import UIKit

public extension UITableView {

    func register<T: UICodeTableViewCell>(_ cellCodeClass: T.Type) {
        self.register(cellCodeClass.self, forCellReuseIdentifier: cellCodeClass.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICodeTableViewCell>(_ reusableCell: T.Type) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: reusableCell.reuseIdentifier) as? T else {
            preconditionFailure("Reusable cell is nil: \(T.self)")
        }
        return cell
    }
}
