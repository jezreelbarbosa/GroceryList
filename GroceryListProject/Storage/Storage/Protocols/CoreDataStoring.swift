//
//  CoreDataStoring.swift
//  Storage
//
//  Created by Jezreel Barbosa on 12/02/21.
//

import CoreData

public protocol CoreDataStoring {

    var persistentContainer: NSPersistentContainer { get }

    func getEntity<T: NSManagedObject>(_ type: T.Type, at uri: URL?) throws -> T
    func getEntity<T: NSManagedObject>(_ type: T.Type) throws -> [T]
    func newEntity<T: EntityNameble>(_ type: T.Type) throws -> T
    func insert(object: NSManagedObject) throws
    func saveIfNeeded() throws
    func remove(itemAt uri: URL) throws
}

extension CoreDataStoring {

    public func getEntity<T: NSManagedObject>(_ type: T.Type, at uri: URL?) throws -> T {
        let coordinator = persistentContainer.persistentStoreCoordinator
        let context = persistentContainer.viewContext
        guard let uri = uri, let objectID = coordinator.managedObjectID(forURIRepresentation: uri),
              let entity = context.object(with: objectID) as? T
        else { throw CoreError.error }
        return entity
    }

    public func getEntity<T: NSManagedObject>(_ type: T.Type) throws -> [T] {
        let context = persistentContainer.viewContext
        let request = type.fetchRequest()
        return try context.fetch(request).compactMap({ $0 as? T })
    }

    public func newEntity<T: EntityNameble>(_ type: T.Type) throws -> T {
        let context = persistentContainer.viewContext

        guard let entityDescription = NSEntityDescription.entity(forEntityName: type.entityName, in: context)
        else { throw CoreError.error }

        return T(entity: entityDescription, insertInto: nil)
    }

    public func insert(object: NSManagedObject) throws {
        let context = persistentContainer.viewContext
        context.insert(object)
        try saveIfNeeded()
    }

    public func saveIfNeeded() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try context.save()
        }
    }

    public func remove(itemAt uri: URL) throws {
        let coordinator = persistentContainer.persistentStoreCoordinator
        let context = persistentContainer.viewContext

        guard let objectID = coordinator.managedObjectID(forURIRepresentation: uri)
        else { throw CoreError.error }

        let entity = context.object(with: objectID)
        context.delete(entity)
        try saveIfNeeded()
    }
}
