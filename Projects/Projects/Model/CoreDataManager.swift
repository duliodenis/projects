//
//  CoreDataManager.swift
//  Projects
//
//  Created by Dulio Denis on 5/30/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    
    
    static func getData(context: NSManagedObjectContext, entity: String, predicate: NSPredicate?=nil) -> [NSManagedObject] {
        var resultsManagedObject: [NSManagedObject] = []
        
        do {
            let request = NSFetchRequest(entityName: entity)
            if (predicate != nil) {
                request.predicate = predicate
            }
            let results = try context.executeFetchRequest(request)
            resultsManagedObject = results as! [NSManagedObject]
            
            
        } catch {
            print("getData: Error retrieving data.")
        }
        
        return resultsManagedObject
    }
    
    
    static func saveData(context: NSManagedObjectContext, item: String, dueDate: NSDate, complete: Bool) {
        let project = NSEntityDescription.insertNewObjectForEntityForName("Projects", inManagedObjectContext: context) as! Projects
        project.item = item
        project.dueDate = dueDate
        project.complete = complete
        
        do {
            try context.save()
        } catch {
            print("save: Error saving.")
        }
    }
    
    
    static func update(context: NSManagedObjectContext, project: Projects) {
        
    }
    
}
