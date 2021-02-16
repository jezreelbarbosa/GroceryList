//
//  CoreDataStorage.swift
//  Storage
//
//  Created by Jezreel Barbosa on 16/02/21.
//

import CoreData

public class CoreDataStorage: CoreDataStoring {

    public var persistentContainer: NSPersistentContainer

    public init() {
        //...

        let modelName = "CoreDataStorage" //pass this as a parameter

        guard let modelURL = Bundle(for: type(of: self)).url(forResource: modelName, withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        let container = NSPersistentContainer(name: modelName, managedObjectModel: model)

        //...

//        let container = NSPersistentContainer(name: "CoreDataStorage")

        container.loadPersistentStores { storeDescription, error in
            debugPrint(storeDescription)
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        self.persistentContainer = container
    }

    public enum ValueKeyable: String, Keyable, CaseIterable {

        case groceryListEntity = "GroceryListEntity"

        public var key: String {
            return rawValue
        }
    }
}
