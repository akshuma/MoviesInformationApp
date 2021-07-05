//
//  CoreDataStack.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 05/07/21.
//

import UIKit

import CoreData

class CoreDataStack {
    private let modelName: String
    static let shared = CoreDataStack()
    
    private init(modelName: String = "MoviesInformationApp") {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = { [unowned self] in
        let container = NSPersistentContainer(name: self.modelName)
        //Added code for light weight migration
        let options = [NSInferMappingModelAutomaticallyOption: true,
                            NSMigratePersistentStoresAutomaticallyOption: true]
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        do {
            try container.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: options)
        } catch {
            debugPrint("error: \(error.localizedDescription)")
        }
       
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                debugPrint("error: \(error.localizedDescription)")
            }
        }
        return container
        
    }()
    
    lazy var managedContext: NSManagedObjectContext = { [unowned self] in
        self.storeContainer.viewContext
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            debugPrint(error)
        }
    }
}
