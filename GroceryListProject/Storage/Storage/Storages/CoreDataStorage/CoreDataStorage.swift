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
        let modelName = "CoreDataStorage"

        guard let modelURL = Bundle(for: type(of: self)).url(forResource: modelName, withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL)
        else { fatalError() }

        let container = NSPersistentContainer(name: modelName, managedObjectModel: model)

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                debugPrint(storeDescription)
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        self.persistentContainer = container
    }
}
