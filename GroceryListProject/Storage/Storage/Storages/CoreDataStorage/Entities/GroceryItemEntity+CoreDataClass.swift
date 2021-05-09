//
//  GroceryItemEntity+CoreDataClass.swift
//  
//
//  Created by Jezreel Barbosa on 08/03/21.
//
//

import CoreData
import AppData

@objc(GroceryItemEntity)
public class GroceryItemEntity: NSManagedObject, EntityNameble {

    // Static Properties

    public static let entityName: String = "GroceryItemEntity"

    // Static functions

    public override class func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    }

    // Properties

    @NSManaged public weak var list: GroceryListEntity?
    @NSManaged public var name: String
    @NSManaged public var quantity: NSDecimalNumber
    @NSManaged public var price: NSDecimalNumber
    @NSManaged public var unit: Int16
    @NSManaged public var date: Date

    var toDTO: GroceryItemDTO {
        GroceryItemDTO(uri: objectID.uriRepresentation(), name: name, quantity: quantity.decimalValue,
                       unit: Int(unit), price: price.decimalValue, date: date)
    }

    // Functions

    func update(name: String, quantity: Decimal, price: Decimal, unit: Int, date: Date) {
        self.name = name
        self.quantity = NSDecimalNumber(decimal: quantity)
        self.price = NSDecimalNumber(decimal: price)
        self.unit = Int16(unit)
        self.date = date
    }
}
