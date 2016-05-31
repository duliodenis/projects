//
//  AddViewController.swift
//  Projects
//
//  Created by Dulio Denis on 5/30/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    var context: NSManagedObjectContext?
    
    @IBOutlet weak var project: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    var dueDate = NSDate()
    var projectAddedBanner = UILabel()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(AddViewController.save))
        
        // make keyboard open when view loads
        project.delegate = self
        project.becomeFirstResponder()
        
        addBanner()
    }
    
    // MARK: Save Method
    
    func save() {
        CoreDataManager.saveData(context!, item: project.text!, dueDate: dueDate, complete: false)
        
        // provide some feedback to user
        presentBanner()
        project.text = ""
        UIView.transitionWithView(project, duration: 0.2, options: .CurveEaseIn, animations: {
            self.project.layer.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0).CGColor
            }, completion: {
                (value:Bool) in
        })
    }
    

    @IBAction func datePickerUpdated(sender: AnyObject) {
        // update our dueDate
        dueDate = dueDatePicker.date
    }
    
    private func addBanner() {
        projectAddedBanner = UILabel(frame: CGRectMake(0, self.navigationController!.navigationBar.frame.maxY, self.view.frame.width, 0))
        projectAddedBanner.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        projectAddedBanner.textAlignment = .Center
        projectAddedBanner.font = UIFont(name: "PathwayGothicOne-Book", size: 23)
        projectAddedBanner.textColor = UIColor.whiteColor()
        projectAddedBanner.text = "You just added a project. Add another one!"
        view.addSubview(projectAddedBanner)
    }
    
    private func presentBanner() {
        //set up the banner
        let hiddenBannerFrame = CGRectMake(0, self.navigationController!.navigationBar.frame.maxY, self.view.frame.width, 0)
        let shownBannerFrame = CGRectMake(0, self.navigationController!.navigationBar.frame.maxY, self.view.frame.width, project.frame.size.height + 20)
        
        // drop it in and pull it out
        if project.text != "" {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 1.5, options: .CurveEaseInOut, animations: {
                self.projectAddedBanner.frame = shownBannerFrame
            }) { (Bool) in
                UIView.animateWithDuration(0.2, delay: 2, usingSpringWithDamping: 1.5, initialSpringVelocity: 1.5, options: .CurveEaseInOut, animations: {
                    self.projectAddedBanner.frame = hiddenBannerFrame
                    }, completion: { (Bool) in
                })
            }
        }
    }
}


// MARK: UITextFieldDelegate Methods

extension AddViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        project.resignFirstResponder()
        return false
    }
    
}