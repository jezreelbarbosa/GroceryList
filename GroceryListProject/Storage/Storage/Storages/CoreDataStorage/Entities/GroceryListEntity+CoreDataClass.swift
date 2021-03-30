//
//  GroceryListEntity+CoreDataClass.swift
//  
//
//  Created by Jezreel Barbosa on 08/03/21.
//
//

import CoreData
import AppData

@objc(GroceryListEntity)
public class GroceryListEntity: NSManagedObject, EntityNameble {

    // Static Properties

    public static let entityName: String = "GroceryListEntity"

    // Static functions

    public override class func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    }

    // Properties

    @NSManaged public var icon: String
    @NSManaged public var name: String
    @NSManaged public var date: Date
    @NSManaged public var items: Set<GroceryItemEntity>

    var toDTO: GroceryListDTO {
        GroceryListDTO(
            uri: objectID.uriRepresentation(), icon: icon, name: name, date: date,
            items: items.compactMap({ $0.toDTO }).sorted(by: { $0.date < $1.date })
        )
    }

    // Functions

    func update(icon: String, name: String, date: Date, items: Set<GroceryItemEntity>) {
        self.icon = icon
        self.name = name
        self.date = date
        self.items = items
    }

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: GroceryItemEntity)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: GroceryItemEntity)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)
}
