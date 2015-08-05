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
    var indexPath : NSIndexPath? = nil
    
    override func loadView()
    {
        self.tableView = UITableView()
        if(thisRecipe != nil)
        {
            actionSource.thisRecipe = thisRecipe
            actionSource.actions = thisRecipe!.actions
            actionSource.options.0 = thisRecipe!.name
            actionSource.options.1 = thisRecipe!.continuous
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
        addExecSheet.addAction(UIAlertAction(title: "Add a Control Flow", style: UIAlertActionStyle.Default, handler: showAddControlFlowVC))
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
            callBackDelegate?.objIsReady((indexPath!,retRecipe))
        }
        else
        {
            print("\n\ncont is: \(actionSource.options.1)")
            retRecipe = thisRecipe!
            retRecipe.name = actionSource.options.0
            retRecipe.continuous = actionSource.options.1
            retRecipe.actions = actionSource.actions
            callBackDelegate!.objIsReady((indexPath!,retRecipe))
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
        actionVC.cfIndexPath = NSIndexPath(forRow: actionSource.actions.count, inSection: 1)
        self.navigationController?.pushViewController(actionVC, animated: true)
    }
    
    func showAddControlFlowVC( _ : UIAlertAction!)
    {
        let addControlFlowVC = ControlFlowTableViewController()
        addControlFlowVC.callbackDelegate = self
        addControlFlowVC.indexPath = NSIndexPath(forRow: 1, inSection: actionSource.actions.count)
        navigationController?.pushViewController(addControlFlowVC, animated: true)
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
                nameVC.indexPath = NSIndexPath(forRow: 0, inSection: 0)
                navigationController?.pushViewController(nameVC, animated: true)
            }
        }
    }
    
    func objIsReady(tup : (NSIndexPath,Any)?)
    {
        let (indexPath, ret) = tup!
        if(indexPath.section == 0 && indexPath.row == 0)
        {
            actionSource.options = (ret as! String, actionSource.options.1)
            self.tableView.reloadData()
        }
        else if(indexPath.section == 1)
        {
            if(indexPath.row == actionSource.actions.count)
            {
                actionSource.actions.append(ret as! Executable)
            }
            else
            {
                actionSource.actions[indexPath.row] = ret as! Executable
            }
        }
        self.tableView.reloadData()
    }
}
