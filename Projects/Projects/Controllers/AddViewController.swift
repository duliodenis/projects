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
    var banner = UILabel()
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
    }
    
    // MARK: Save Method
    
    func save() {
        // provide some feedback to user
        if project.text != "" {
            CoreDataManager.saveData(context!, item: project.text!, dueDate: dueDate, complete: false)
            dropBannerWithSuccessfulProject(true)
            project.text = ""
            
            // waits 2 seconds then raises banner
            raiseBanner()
        } else {
            dropBannerWithSuccessfulProject(false)
            raiseBanner()
        }
    }
    

    @IBAction func datePickerUpdated(sender: AnyObject) {
        // update our dueDate
        dueDate = dueDatePicker.date
    }
    
    private func setUpAnimatorAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior(items: [banner])
        let barrierFrame = CGRectMake(0, navigationController!.navigationBar.frame.maxY + 64, view.frame.size.width, 1)
        collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: barrierFrame))
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
    }
    
    private func configureBannerForSuccessfulProject(success: Bool) {
        banner = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 64))
        banner.textAlignment = .Center
        banner.font = UIFont(name: "PathwayGothicOne-Book", size: 23)
        banner.textColor = UIColor.whiteColor()
        
        if success == true {
            banner.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
            banner.text = "You just added a project. Add another one!"
        } else {
            banner.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
            banner.text = "Yo, you need a name for your thing"
        }
        
        view.addSubview(banner)
    }
    
    private func dropBannerWithSuccessfulProject(success: Bool) {
        if success == true {
            configureBannerForSuccessfulProject(true)
        } else {
            configureBannerForSuccessfulProject(false)
        }
        setUpAnimatorAndBehaviors()
        gravity.addItem(banner)
    }
    
    private func raiseBanner() {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 1.5, options: .CurveEaseOut, animations: {
                self.banner.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
            }) { (Bool) in
            }        }
    }
    
}


// MARK: UITextFieldDelegate Methods

extension AddViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        project.resignFirstResponder()
        return false
    }
    
}