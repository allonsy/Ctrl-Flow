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
        actionVC.indexPath = NSIndexPath(forRow: actionSource.actions.count, inSection: 1)
        self.navigationController?.pushViewController(actionVC, animated: true)
    }
    
    func showAddControlFlowVC( _ : UIAlertAction!)
    {
        let addControlFlowVC = ControlFlowTableViewController()
        addControlFlowVC.callbackDelegate = self
        addControlFlowVC.indexPath = NSIndexPath(forRow: actionSource.actions.count, inSection: 1)
        navigationController?.pushViewController(addControlFlowVC, animated: true)
    }
    
    func genToolBarSpacer() -> UIBarButtonItem
    {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    }
    
    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0)
        {
            if(indexPath.row == 0)
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
        else
        {
            let selectedExec = actionSource.actions[indexPath.row]
            if let selectedAction = selectedExec as? Action
            {
                if(selectedAction.argumentPickerVC == nil)
                {
                    let actionVC = ActionViewController()
                    actionVC.callbackDelegate = self
                    actionVC.indexPath = indexPath
                    self.navigationController?.pushViewController(actionVC, animated: true)
                }
                else
                {
                    let actionVC = selectedAction.argumentPickerVC!
                    actionVC.callbackDelegate = self
                    actionVC.indexPath = indexPath
                    actionVC.thisObj = selectedAction
                    navigationController?.pushViewController(actionVC, animated: true)
                }
            }
            else if let selectedControl = selectedExec as? ControlFlow
            {
                if(selectedControl.controlFlowPickerVC == nil)
                {
                    let controlVC = EditControlFlowTableViewController()
                    controlVC.thisControl = selectedControl
                    controlVC.callbackDelegate = self
                    controlVC.indexPath = indexPath
                    self.navigationController?.pushViewController(controlVC, animated: true)
                }
                else
                {
                    let controlVC = selectedControl.controlFlowPickerVC!
                    controlVC.callbackDelegate = self
                    controlVC.indexPath = indexPath
                    controlVC.thisObj = selectedControl
                    navigationController?.pushViewController(controlVC, animated: true)
                }
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
    func toggleEditMode(sender : UIButton!)
    {
        self.tableView.setEditing(!self.tableView.editing, animated: true)
        if(self.tableView.editing)
        {
            sender.setTitle("Done", forState: UIControlState.Normal)
        }
        else
        {
            sender.setTitle("Edit", forState: UIControlState.Normal)
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40.0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return getCustomSectionHeader(tableView, section : section)
    }
    func getCustomSectionHeader(tableView : UITableView, section : Int) -> UIView
    {
        let retView = UITableViewHeaderFooterView()
        if(section == 0)
        {
            retView.textLabel.text = "Options"
        }
        else
        {
            let width  = CGRectGetWidth(tableView.frame)
            let height = self.tableView(tableView, heightForHeaderInSection: 0)
            let magicNumber = 3.0
            let ypos = 0.0
            let totalHeight = CGFloat(Double(height) - ypos)
            let totalWidth = CGFloat(50.0)
            let xpos = Double(width) - Double(totalWidth) - magicNumber
            retView.textLabel.text = "Actions"
            let editButton : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            editButton.frame = CGRectMake(CGFloat(xpos), CGFloat(ypos), totalWidth, totalHeight)
            editButton.clipsToBounds = true
            editButton.setTitle("Edit", forState: UIControlState.Normal)
            editButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
            editButton.addTarget(self, action: "toggleEditMode:", forControlEvents: UIControlEvents.TouchUpInside)
            retView.contentView.addSubview(editButton)
        }
        return retView
    }
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel.textColor = UIColor.blackColor()
    }
}
