//
//  TaskDB.swift
//  AV2Ios
//
//  Created by administrador on 23/10/2018.
//  Copyright © 2018 administrador. All rights reserved.
//

import Foundation
import CoreData

class TaskDB {
    static let instance = TaskDB()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func newTask() -> Task? {
        let task = NSEntityDescription.insertNewObject(forEntityName: "Task", into: self.persistentContainer.viewContext) as? Task
        
        return task
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func allTasks() -> [Task] {
        
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            let searchResults = try self.persistentContainer.viewContext.fetch(request)
            
            return searchResults
            
        } catch {
            print("Error with request: \(error)")
        }
        
        return [Task]()
    }
    
    func delete(task:Task) -> Void {
        self.persistentContainer.viewContext.delete(task)
    }

}



