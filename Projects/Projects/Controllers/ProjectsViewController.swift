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
    
    var itemsDueToday: [Projects] = []
    var itemsDueThisWeek: [Projects] = []
    var projects: [Projects] = []
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // apply a color to the navigation bar
        navigationController?.navigationBar.barTintColor = UIColor(red: 155/255, green: 174/255, blue: 255/255, alpha: 1)
        
        // apply a color to the title text
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        // apply a tint color to the nav bar to color the bar button items
        navigationController?.navigationBar.tintColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
        
        // set the delegate and data sources of our three tables
        dueTodayTableView.delegate = self
        dueTodayTableView.dataSource = self
        dueThisWeekTableView.delegate = self
        dueThisWeekTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        // register TableViewCells
        dueTodayTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        dueThisWeekTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mainTableView.registerClass(MainTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshUI()
    }
    
    
    // MARK: Refresh UI Method
    
    func refreshUI() {
        projects = CoreDataManager.getData(context!, entity: "Projects") as! [Projects]
        
        let todayPredicate = NSPredicate(format: "dueDate <= %@", NSDate())
        itemsDueToday = CoreDataManager.getData(context!, entity: "Projects", predicate: todayPredicate) as! [Projects]
        
        let dayComponent = NSDateComponents()
        dayComponent.day = 7
        let theCalendar = NSCalendar.currentCalendar()
        let nextDate = theCalendar.dateByAddingComponents(dayComponent, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
        let weekPredicate = NSPredicate(format: "dueDate < %@", nextDate!)
        itemsDueThisWeek = CoreDataManager.getData(context!, entity: "Projects", predicate: weekPredicate) as! [Projects]
        
        dueTodayTableView.reloadData()
        dueThisWeekTableView.reloadData()
        mainTableView.reloadData()
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


extension ProjectsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}

extension ProjectsViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dueTodayTableView {
            dueTodayCount.text = String(itemsDueToday.count)
            return itemsDueToday.count
        }
        else if tableView == dueThisWeekTableView {
            dueThisWeekCount.text = String(itemsDueThisWeek.count)
            return itemsDueThisWeek.count
        }
        else {
            return projects.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == dueTodayTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            let dueToday = itemsDueToday[indexPath.row]
            cell.textLabel?.text = "\(dueToday.item!), \(dueToday.dueDate!)"
            return cell
        }
            
        else if tableView == dueThisWeekTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            let dueThisWeek = itemsDueThisWeek[indexPath.row]
            cell.textLabel?.text = "\(dueThisWeek.item!), \(dueThisWeek.dueDate!)"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath) as! MainTableViewCell
            let mainProjects = projects[indexPath.row]

            if mainProjects.complete?.boolValue == true {
                cell.imageView?.image = UIImage(named: "checkmark")
            } else {
                cell.imageView?.image = UIImage(named: "uncheckmark")
            }
            
            cell.textLabel?.text = "\(mainProjects.item!), \(mainProjects.dueDate!)"
            return cell
        }
    }
    
}
