//
//  ActionSource.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/31/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class ActionDataSource : NSObject,UITableViewDataSource {
    
    var actions = [Executable]()
    //var recipes = [Recipe(name: "Hello", actions: [Executable](), continuous: false)]
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return actions.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return getCellForAction(actions[indexPath.indexAtPosition(1)])
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
}
