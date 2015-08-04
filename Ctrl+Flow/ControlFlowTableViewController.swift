//
//  ControlFlowViewControllerTableViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/4/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class ControlFlowTableViewController: UITableViewController,CallbackWhenReadyDelegate, UITableViewDelegate
{
    var callbackDelegate : CallbackWhenReadyDelegate? = nil
    var dataController = ControlFlowDataController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedControl = dataController.controlFlows[indexPath.row]
        let newControl = selectedControl.returnControlFlow()
        if(newControl.controlFlowPickerVC == nil)
        {
            objIsReady(newControl)
        }
        else
        {
            newControl.controlFlowPickerVC!.callbackDelegate = self
            navigationController?.pushViewController(newControl.controlFlowPickerVC!, animated: true)
        }
    }
    
    func objIsReady(ret: Any?)
    {
        callbackDelegate?.objIsReady(ret)
        navigationController?.popViewControllerAnimated(true)
    }

    
}
