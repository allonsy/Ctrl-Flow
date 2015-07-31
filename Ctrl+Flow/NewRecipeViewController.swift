//
//  NewRecipeViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/31/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class NewRecipeViewController: UITableViewController
{
    let actionSource = ActionDataSource()
    
    override func loadView()
    {
        self.tableView = UITableView()
        self.tableView.dataSource = actionSource
    }
    
    override func viewDidLoad()
    {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "showAddExecutableSheet");
        self.title = NSLocalizedString("add-recipe-title", comment: "")
    }
    
    func showAddExecutableSheet()
    {
        let addExecSheet = UIAlertController(title: "Add An Action", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        addExecSheet.addAction(UIAlertAction(title: "Add a Control Flow", style: UIAlertActionStyle.Default, handler: nil))
        addExecSheet.addAction(UIAlertAction(title: "Add an Action", style: UIAlertActionStyle.Default, handler: nil))
        addExecSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(addExecSheet, animated: true, completion: nil)
    }

}
