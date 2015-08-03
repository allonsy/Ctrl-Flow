//
//  ActionDataController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/3/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class ActionDataController : NSObject,UITableViewDataSource,UITableViewDelegate
{
    let actions : [ActionWrapper] = CFGlobal.actions
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return getActionCellForIndex(indexPath.indexAtPosition(1))
    }
    
    func getActionCellForIndex(index : Int) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "actionCell")
        cell.textLabel?.text = actions[index].name + ": " + actions[index].description
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return actions.count
        }
        else
        {
            return 0
        }
    }
}
