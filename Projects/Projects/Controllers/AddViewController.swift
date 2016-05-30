//
//  AddViewController.swift
//  Projects
//
//  Created by Dulio Denis on 5/30/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
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