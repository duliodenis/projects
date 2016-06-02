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
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: Selector("save"))
        
        // make keyboard open when view loads
        project.delegate = self
        project.becomeFirstResponder()
        
        configureProjectAddedBanner()
        setUpAnimatorAndBehaviors()
    }
    
    // MARK: Save Method
    
    func save() {
        // provide some feedback to user
        if project.text != "" {
            CoreDataManager.saveData(context!, item: project.text!, dueDate: dueDate, complete: false)
            dropProjectAddedBanner()
            project.text = ""
            
            // wait 2 seconds before raising the banner
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                self.raiseProjectAddedBanner()
            }
        }
    }
    

    @IBAction func datePickerUpdated(sender: AnyObject) {
        // update our dueDate
        dueDate = dueDatePicker.date
    }
    
    private func setUpAnimatorAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior(items: [projectAddedBanner])
        let barrierFrame = CGRectMake(0, navigationController!.navigationBar.frame.maxY + 64, view.frame.size.width, 1)
        collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: barrierFrame))
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
    }
    
    private func configureProjectAddedBanner() {
        projectAddedBanner = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 64))
        projectAddedBanner.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        projectAddedBanner.textAlignment = .Center
        projectAddedBanner.font = UIFont(name: "PathwayGothicOne-Book", size: 23)
        projectAddedBanner.textColor = UIColor.whiteColor()
        projectAddedBanner.text = "You just added a project. Add another one!"
        view.addSubview(projectAddedBanner)
    }
    
    private func dropProjectAddedBanner() {
        setUpAnimatorAndBehaviors()
        gravity.addItem(projectAddedBanner)
    }
    
    private func raiseProjectAddedBanner() {
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 1.5, options: .CurveEaseOut, animations: {
            self.projectAddedBanner.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
            }) { (Bool) in
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