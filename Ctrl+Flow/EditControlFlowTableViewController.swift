//
//  EditControlFlowViewControllerTableViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/4/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class EditControlFlowTableViewController: UITableViewController,CallbackWhenReadyDelegate,UITableViewDelegate
{
    var callbackDelegate : CallbackWhenReadyDelegate? = nil
    var dataController : EditControlFlowDataController = EditControlFlowDataController()
    var indexPath : NSIndexPath? = nil
    
    init(controlFlow : ControlFlow)
    {
        super.init(style:UITableViewStyle.Plain)
        dataController.thisControl = controlFlow
        dataController.condition = controlFlow.condition
        dataController.actions = controlFlow.actions
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView()
    {
        tableView = UITableView()
        tableView.dataSource = dataController
        tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "showAddExecutableSheet")
        self.title = "Edit Control Flow"
        let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "saveButtonPressed")
        self.toolbarItems = [genToolBarSpacer(), saveButton, genToolBarSpacer()]
        self.navigationController?.toolbarHidden = false
    }
    func showAddExecutableSheet()
    {
        let addExecSheet = UIAlertController(title: "Add An Action", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        addExecSheet.addAction(UIAlertAction(title: "Add a Control Flow", style: UIAlertActionStyle.Default, handler: showAddControlFlowVC))
        addExecSheet.addAction(UIAlertAction(title: "Add an Action", style: UIAlertActionStyle.Default, handler: showAddActionVC))
        addExecSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(addExecSheet, animated: true, completion: nil)
    }
    
    func showAddActionVC( _ : UIAlertAction!)
    {
        let actionVC = ActionViewController()
        actionVC.callbackDelegate = self
        actionVC.indexPath = NSIndexPath(forRow: dataController.actions.count, inSection: 1)
        self.navigationController?.pushViewController(actionVC, animated: true)
    }
    
    func objIsReady(tup : (NSIndexPath, Any)?)
    {
        if(tup == nil)
        {
            return
        }
        let (index, ret) = tup!
        if(index.section == 0)
        {
            dataController.condition = (ret as! Condition)
        }
        else
        {
            if(index.row == dataController.actions.count)
            {
                dataController.actions.append(ret as! Executable)
            }
            else
            {
                dataController.actions[index.row] = ret as! Executable
            }
        }
    }
    
    func saveButtonPressed()
    {
        let newCF = dataController.thisControl!
        newCF.actions = dataController.actions
        newCF.condition = dataController.condition!
        callbackDelegate?.objIsReady((indexPath!,newCF))
    }
    
    func showAddControlFlowVC(_ :UIAlertAction!)
    {
        let cfVC = ControlFlowTableViewController()
        cfVC.indexPath = NSIndexPath(forRow: dataController.actions.count, inSection: 1)
        cfVC.callbackDelegate = self
        navigationController?.pushViewController(cfVC, animated: true)
    }

    func genToolBarSpacer() -> UIBarButtonItem
    {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if(indexPath.section == 0)
        {
            if(dataController.condition == nil)
            {
                let conditionVC = ConditionTableViewController()
                conditionVC.callbackDelegate = self
                conditionVC.indexPath = indexPath
                navigationController?.pushViewController(conditionVC, animated: true)
            }
            else
            {
                let selectedCondition = dataController.condition!
                if(selectedCondition.argumentPickerVC == nil)
                {
                    let conditionVC = ConditionTableViewController()
                    conditionVC.callbackDelegate = self
                    conditionVC.indexPath = indexPath
                    navigationController?.pushViewController(conditionVC, animated: true)
                }
                else
                {
                    let conditionVC = selectedCondition.argumentPickerVC!
                    conditionVC.callbackDelegate = self
                    conditionVC.indexPath = indexPath
                    navigationController?.pushViewController(conditionVC, animated: true)
                }
            }
        }
        else
        {
            let selectedExec = dataController.actions[indexPath.row]
            if let selectedAction = selectedExec as? Action
            {
                if(selectedAction.argumentPickerVC == nil)
                {
                    let actionVC = ActionViewController()
                    actionVC.callbackDelegate = self
                    actionVC.indexPath = indexPath
                    navigationController?.pushViewController(actionVC, animated: true)
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
                    let editControlVC = EditControlFlowTableViewController(controlFlow: selectedControl)
                    editControlVC.callbackDelegate = self
                    editControlVC.indexPath = indexPath
                    navigationController?.pushViewController(editControlVC, animated: true)
                }
                else
                {
                    let editControlVC = selectedControl.controlFlowPickerVC!
                    editControlVC.callbackDelegate = self
                    editControlVC.thisObj = selectedControl
                    editControlVC.indexPath = indexPath
                    navigationController?.pushViewController(editControlVC, animated: true)
                }
            }
        }
    }

}
