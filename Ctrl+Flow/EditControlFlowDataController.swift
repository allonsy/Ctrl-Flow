//
//  EditControlFlowDataController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/4/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class EditControlFlowDataController: NSObject,UITableViewDataSource
{
    var thisControl : ControlFlow? = nil
    var condition : Condition? = nil
    var actions : [Executable] = [Executable]()
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            return getConditonCell()
        }
        else
        {
            return getActionCellForIndex(indexPath.row)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 1
        }
        else
        {
            return actions.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }
    
    func getConditonCell() -> UITableViewCell
    {
        let retCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "conditionEdit Cell")
        if(condition == nil)
        {
            retCell.textLabel!.text = "Condition"
        }
        else
        {
            retCell.textLabel!.text = condition!.name
        }
        return retCell
    }
    
    func getActionCellForIndex(index : Int) -> UITableViewCell
    {
        let retCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "actionEdit Cell")
        let selectedExec = actions[index]
        retCell.textLabel?.text = selectedExec.getName()
        return retCell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        if(indexPath.section == 1)
        {
            return true
        }
        return false
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        if(indexPath.section == 1)
        {
            return true
        }
        return false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            self.actions.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
    {
        let index1 = sourceIndexPath.row
        let index2 = destinationIndexPath.row
        
        if(index1 == index2)
        {
            return
        }
        
        let temp = actions[index1]
        actions.removeAtIndex(index1)
        actions.insert(temp, atIndex: index2)
    }
    
    
}
