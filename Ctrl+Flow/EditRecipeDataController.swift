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
        options = (thisRecipe!.name,thisRecipe!.activated)
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
            retCell.accessoryView = contSwitch
        default:
            break;
        }
        return retCell
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
            actions.removeAtIndex(indexPath.indexAtPosition(1));
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0)
        {
            return "Options"
        }
        else
        {
            return "Actions"
        }
    }
}