//
//  ActionSource.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/31/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class EditRecipeDataController : NSObject,UITableViewDataSource
{
    var actions : [Executable]
    var thisRecipe : Recipe?
    var options : (String, Bool)
    
    override init()
    {
        thisRecipe = nil
        actions = [Executable]()
        options = ("Name", true)

    }
    
    init(recipe: Recipe)
    {
        thisRecipe = recipe
        actions = thisRecipe!.actions
        options = (thisRecipe!.name,thisRecipe!.continuous)
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1)
        {
            return actions.count
        }
        else
        {
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.indexAtPosition(0) == 1)
        {
            return getCellForAction(actions[indexPath.indexAtPosition(1)])
        }
        else
        {
            return getOptionCellForIndex(indexPath.indexAtPosition(1))
        }
    }
    
    func getOptionCellForIndex(index : Int) -> UITableViewCell
    {
        let retCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "actionCell")
        switch index
        {
        case 0:
            retCell.textLabel!.text = "Name: " + options.0
        case 1:
            retCell.textLabel?.text = "Continuous"
            let contSwitch = UISwitch()
            contSwitch.on = options.1
            contSwitch.addTarget(self, action: "switchPressed", forControlEvents: UIControlEvents.TouchUpInside)
            retCell.accessoryView = contSwitch
        default:
            break;
        }
        return retCell
    }
    
    func switchPressed()
    {
        options.1 = !options.1
    }
    
    func getCellForAction(act : Executable) -> UITableViewCell
    {
        let retCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "actionCell")
        retCell.textLabel!.text = act.getName()
        return retCell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            actions.removeAtIndex(indexPath.row);
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
        
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        if(indexPath.section == 1)
        {
            return true
        }
        else
        {
            return false
        }
    }
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        if(indexPath.section == 1)
        {
            return true
        }
        return false
    }
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
    {
        let index1 = sourceIndexPath.row
        let index2 = destinationIndexPath.row
        if index1 == index2
        {
            return
        }
        else
        {
            let temp = actions[index1]
            actions.removeAtIndex(index1)
            actions.insert(temp, atIndex: index2)
        }
    }
}
