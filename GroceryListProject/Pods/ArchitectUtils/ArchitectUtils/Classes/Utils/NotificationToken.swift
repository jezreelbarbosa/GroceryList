//
//  NotificationToken.swift
//  
//
//  Created by Jezreel Barbosa on 08/05/21.
//

import UIKit

public final class NotificationToken {

    private let notificationCenter: NotificationCenter
    private let token: NSObjectProtocol

    public init(notificationCenter: NotificationCenter = .default, token: NSObjectProtocol) {
        self.notificationCenter = notificationCenter
        self.token = token
    }

    deinit {
        notificationCenter.removeObserver(token)
    }
}

public extension NotificationCenter {

    func addObserver(name: NSNotification.Name?, object obj: Any?, queue: OperationQueue?,
                     using block: @escaping (Notification) -> Void) -> NotificationToken {
        let token = addObserver(forName: name, object: obj, queue: queue, using: block)
        return NotificationToken(notificationCenter: self, token: token)
    }
}

public protocol ContentSizeObserver: AnyObject {

    var notificationTokens: [NotificationToken] { get set }
    func bindObserver(andFire fire: Bool, contentSizeCategoryDidChange completion: @escaping (UIContentSizeCategory) -> Void)
}

public extension ContentSizeObserver where Self: UITraitEnvironment {

    func bindObserver(andFire fire: Bool = true, contentSizeCategoryDidChange completion: @escaping (UIContentSizeCategory) -> Void) {
        let name = UIContentSizeCategory.didChangeNotification
        let token = NotificationCenter.default.addObserver(name: name, object: nil, queue: .main) { [weak self] _ in
            guard let self = self else { return }

            completion(self.traitCollection.preferredContentSizeCategory)
        }
        notificationTokens.append(token)
        if fire {
            completion(self.traitCollection.preferredContentSizeCategory)
        }
    }
}
