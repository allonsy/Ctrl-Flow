//
//  NewRecipeViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/31/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class EditRecipeViewController: UITableViewController,CallbackWhenReadyDelegate
{
    var actionSource = EditRecipeDataController()
    var vcTitle : String = NSLocalizedString("add-recipe-title", comment: "")
    var thisRecipe : Recipe?
    weak var callBackDelegate : CallbackWhenReadyDelegate?
    
    override func loadView()
    {
        self.tableView = UITableView()
        if(thisRecipe != nil)
        {
            actionSource.thisRecipe = thisRecipe
            actionSource.actions = thisRecipe!.actions
            actionSource.options.0 = thisRecipe!.name
            actionSource.options.1 = thisRecipe!.activated
        }
        self.tableView.dataSource = actionSource
        self.tableView.delegate = self
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
        addExecSheet.addAction(UIAlertAction(title: "Add an Action", style: UIAlertActionStyle.Default, handler: showAddActionVC))
        addExecSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(addExecSheet, animated: true, completion: nil)
    }
    func saveButtonPressed()
    {
        let retRecipe : Recipe
        if(thisRecipe == nil)
        {
            retRecipe = Recipe(name: actionSource.options.0, actions: actionSource.actions, continuous: actionSource.options.1)
            callBackDelegate?.objIsReady(retRecipe)
        }
        else
        {
            retRecipe = thisRecipe!
            retRecipe.name = actionSource.options.0
            retRecipe.activated = actionSource.options.1
            retRecipe.actions = actionSource.actions
            callBackDelegate!.objIsReady(nil)
        }
        if(callBackDelegate != nil)
        {
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
    func showAddActionVC( _ : UIAlertAction!)
    {
        let actionVC = ActionViewController()
        actionVC.callbackDelegate = self
        self.navigationController?.pushViewController(actionVC, animated: true)
    }
    
    func genToolBarSpacer() -> UIBarButtonItem
    {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    }
    
    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.indexAtPosition(0) == 0)
        {
            if(indexPath.indexAtPosition(1) == 0)
            {
                let nameVC = CFTextViewController(nibName:"CFTextViewController", bundle:nil)
                nameVC.callbackDelegate = self
                if(actionSource.thisRecipe == nil)
                {
                    nameVC.hintText = "Name"
                }
                else
                {
                    nameVC.hintText = actionSource.thisRecipe!.name
                }
                navigationController?.pushViewController(nameVC, animated: true)
            }
        }
    }
    
    func objIsReady(ret : Any?)
    {
        print("In obj")
        if let retString = ret as? String
        {
            actionSource.options = (retString, actionSource.options.1)
            self.tableView.reloadData()
        }
        if let retAction = ret as? Executable
        {
            print("In data reload")
            actionSource.actions.append(retAction)
            self.tableView.reloadData()
        }
    }
}
