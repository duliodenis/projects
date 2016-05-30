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
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: Selector("save"))
        
        project.delegate = self
        
    }
    
    // MARK: Save Method
    
    func save() {
        print("Saving: \(dueDate)")
        CoreDataManager.saveData(context!, project: project.text!, dueDate: dueDate, complete: false)
        
        // provide some feedback to user
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
}


// MARK: UITextFieldDelegate Methods

extension AddViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        project.resignFirstResponder()
        return false
    }
    
}