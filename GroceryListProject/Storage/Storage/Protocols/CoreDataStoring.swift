//
//  CoreDataStoring.swift
//  Storage
//
//  Created by Jezreel Barbosa on 12/02/21.
//

import Common
import CoreData

public protocol CoreDataStoring {

    associatedtype ValueKeyable: Keyable, CaseIterable

    var persistentContainer: NSPersistentContainer { get }

    func setNew(values: [String: Any?], entity: ValueKeyable, item: (key: String, value: UUID)) throws
    func update(values: [String: Any?], entity: ValueKeyable, item: (key: String, value: UUID)) throws
    func remove(entity: ValueKeyable, item: (key: String, value: UUID)) throws
    func removeAll(entity: ValueKeyable) throws
    func get(entity: ValueKeyable) throws -> [[String: Any?]]
    func get(entity: ValueKeyable, item: (key: String, value: UUID)) throws -> [String: Any?]
}

extension CoreDataStoring {

    public func setNew(values: [String: Any?], entity: ValueKeyable, item: (key: String, value: UUID)) throws {
        let context = persistentContainer.viewContext
        let object = NSEntityDescription.insertNewObject(forEntityName: entity.key, into: context)

        object.setValue(item.value, forKey: item.key)
        values.forEach({ object.setValue($0.value, forKey: $0.key) })

        try context.save()
    }

    public func update(values: [String: Any?], entity: ValueKeyable, item: (key: String, value: UUID)) throws {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: entity.key)

        guard let object = try context.fetch(request).first(where: { ($0.value(forKey: item.key) as? UUID) == item.value }) else {
            throw CoreError.error
        }
        object.setValuesForKeys(values as [String: Any])

        try context.save()
    }

    public func remove(entity: ValueKeyable, item: (key: String, value: UUID)) throws {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: entity.key)

        guard let object = try context.fetch(request).first(where: { ($0.value(forKey: item.key) as? UUID) == item.value }) else {
            throw CoreError.error
        }

        context.delete(object)
    }

    public func removeAll(entity: ValueKeyable) throws {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: entity.key)
        let objects = try context.fetch(request)

        objects.forEach({ context.delete($0) })
    }

    public func get(entity: ValueKeyable) throws -> [[String: Any?]] {
        let context = persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: entity.key, in: context)
        let request = NSFetchRequest<NSManagedObject>(entityName: entity.key)
        let entityKeys = entityDescription?.attributesByName.enumerated().map { $0.element.key } ?? []

        return try context.fetch(request).map({ $0.dictionaryWithValues(forKeys: entityKeys) })
    }

    public func get(entity: ValueKeyable, item: (key: String, value: UUID)) throws -> [String: Any?] {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: entity.key)
        let entityKeys = request.entity?.attributesByName.enumerated().map { $0.element.key } ?? []

        guard let object = try context.fetch(request).first(where: { ($0.value(forKey: item.key) as? UUID) == item.value }) else {
            throw CoreError.error
        }

        return object.dictionaryWithValues(forKeys: entityKeys)
    }
}
