//
//  PersistenceManager.swift
//  CoreDataSetup
//
//  Created by Xin Zou on 11/26/18.
//  Copyright © 2018 Xin Zou. All rights reserved.
//

import Foundation
import CoreData

class PersistenceManager {
    
    private init() {}
    
    static let shared = PersistenceManager()
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataSetup")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support
    
    func save() {

        if context.hasChanges {
            do {
                try context.save()
                print("[SUCCESS] save success!!!")
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let rlt = try context.fetch(fetchRequest) as? [T]
            return rlt ?? [T]()

        } catch {
            print("[ERROR] fail to fetch object: \(entityName)")
            return [T]()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        save()
    }
    
}
