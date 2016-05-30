//
//  ProjectsViewController.swift
//  Projects
//
//  Created by Dulio Denis on 5/30/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit
import CoreData

class ProjectsViewController: UIViewController {
    
    var context: NSManagedObjectContext?

    @IBOutlet weak var dueTodayTableView: UITableView!
    @IBOutlet weak var dueThisWeekTableView: UITableView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var dueTodayCount: UILabel!
    @IBOutlet weak var dueThisWeekCount: UILabel!
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // apply a color to the navigation bar
        navigationController?.navigationBar.barTintColor = UIColor(red: 155/255, green: 174/255, blue: 255/255, alpha: 1)
        
        // apply a color to the title text
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        // apply a tint color to the nav bar to color the bar button items
        navigationController?.navigationBar.tintColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
        
        dueTodayCount.text = "0"
        dueThisWeekCount.text = "0"
    }
    
    
    // MARK: Segue to AddViewController
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddViewController" {
            let nextViewController = segue.destinationViewController as! AddViewController
            // pass the Managed Context to the AddViewController
            nextViewController.context = context
        }
    }
}
