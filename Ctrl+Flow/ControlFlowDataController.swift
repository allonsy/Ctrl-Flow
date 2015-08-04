//
//  ControlFlowDataController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/4/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class ControlFlowDataController: NSObject,UITableViewDataSource
{
    let controlFlows = CFGlobal.controls
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
            return controlFlows.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let selectedControl = controlFlows[indexPath.row]
        let retCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "controlFlowCell")
        retCell.textLabel?.text = selectedControl.name + ": " + selectedControl.description
        return retCell
    }
}
