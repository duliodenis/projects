//
//  AppDelegate.swift
//  Projects
//
//  Created by Dulio Denis on 5/30/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        let nav = self.window?.rootViewController as? UINavigationController
        let projectsVC = nav?.topViewController as? ProjectsViewController
        
        // setup the context with the Main Queue Concurrency Type
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        
        // setup the coordinator using our CoreDataStack Singleton
        context.persistentStoreCoordinator = CoreDataStack.sharedInstance.coordinator
        
        // assign the context of the All Chats VC to this context we just setup
        projectsVC?.context = context
        
        return true
    }
    
}

