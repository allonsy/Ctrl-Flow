//
//  NewRecipeViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/31/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class EditRecipeViewController: UITableViewController
{
    var actionSource = EditRecipeDataController()
    var vcTitle : String = NSLocalizedString("add-recipe-title", comment: "")
    var thisRecipe : Recipe?
    
    override func loadView()
    {
        self.tableView = UITableView()
        if let actions = thisRecipe?.actions
        {
            actionSource.actions = actions
        }
        self.tableView.dataSource = actionSource
    }
    
    override func viewDidLoad()
    {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "showAddExecutableSheet");
        self.title = vcTitle
        let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "saveButtonPressed")
        self.toolbarItems = [genToolBarSpacer(), saveButton, genToolBarSpacer()]
        self.navigationController!.toolbarHidden = false
    }
    
    func showAddExecutableSheet()
    {
        let addExecSheet = UIAlertController(title: "Add An Action", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        addExecSheet.addAction(UIAlertAction(title: "Add a Control Flow", style: UIAlertActionStyle.Default, handler: nil))
        addExecSheet.addAction(UIAlertAction(title: "Add an Action", style: UIAlertActionStyle.Default, handler: nil))
        addExecSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(addExecSheet, animated: true, completion: nil)
    }
    func saveButtonPressed()
    {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func genToolBarSpacer() -> UIBarButtonItem
    {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    }
}
