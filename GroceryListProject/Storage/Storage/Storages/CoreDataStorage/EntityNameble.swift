//
//  EntityNameble.swift
//  Storage
//
//  Created by Jezreel Barbosa on 30/03/21.
//

import CoreData

public protocol EntityNameble: NSManagedObject {

    static var entityName: String { get }
}
