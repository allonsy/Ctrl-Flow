//
//  ActionViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/3/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class ActionViewController: UITableViewController
{
    let dataController = ActionDataController()
    
    override func loadView() {
        tableView = UITableView()
        tableView.dataSource = dataController
        tableView.delegate = dataController
        
    }
    
    override func viewDidLoad() {
        self.title = "Pick an Action"
    }

}
