//
//  ConditionDataController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/4/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class ConditionDataController: NSObject,UITableViewDataSource
{
    let conditions = CFGlobal.conditions
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        return getConditionCellForIndex(indexPath.row)
    }
    
    func getConditionCellForIndex(index : Int) -> UITableViewCell
    {
        let retCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "conditionCell")
        retCell.textLabel?.text = conditions[index].name + ": " + conditions[index].description
        return retCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
            return conditions.count
        }
        else
        {
            return 0
        }
    }
}
