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
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0)
        {
            return "Condition"
        }
        else
        {
            return "Actions"
        }
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
}
