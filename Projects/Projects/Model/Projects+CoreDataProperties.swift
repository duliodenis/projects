//
//  Projects+CoreDataProperties.swift
//  Projects
//
//  Created by Dulio Denis on 5/30/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Projects {

    @NSManaged var item: String?
    @NSManaged var dueDate: NSDate?
    @NSManaged var complete: NSNumber?

}
