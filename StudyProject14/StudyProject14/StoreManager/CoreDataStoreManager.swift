//
//  CoreDataStoreManager.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 11.03.2021.
//

import Foundation
import CoreData

final class CoreDataManager: DataBaseManager {
    func load() -> [ToDoItem] {
        let request: NSFetchRequest = ToDoItem.fetchRequest()
        guard let models = try? context.fetch(request) else {
            return []
        }
        
        return models
    }
    
    func add(objectWithTitle title: String) -> ToDoItem {
        let toDoItem = ToDoItem(context: context)
        toDoItem.title = title
        save()
        
        return toDoItem
    }
    
    func delete(object: ToDoItem) {
        context.delete(object)
        save()
    }
    
    private func save() {
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StudyProject14")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
