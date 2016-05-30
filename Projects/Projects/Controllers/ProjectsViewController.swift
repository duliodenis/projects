//
//  ProjectsViewController.swift
//  Projects
//
//  Created by Dulio Denis on 5/30/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {

    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // apply a color to the navigation bar
        navigationController?.navigationBar.barTintColor = UIColor(red: 155/255, green: 174/255, blue: 255/255, alpha: 1)
        
        // apply a color to the title text
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        // apply a tint color to the nav bar to color the bar button items
        navigationController?.navigationBar.tintColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
        
    }
}
