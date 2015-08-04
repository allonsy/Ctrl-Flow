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
    var indexPath : NSIndexPath? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add a Control Flow"
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
            let editCFVC = EditControlFlowTableViewController(controlFlow: newControl)
            editCFVC.callbackDelegate = self
            editCFVC.indexPath = self.indexPath
            navigationController?.pushViewController(editCFVC, animated: true)
        }
        else
        {
            newControl.controlFlowPickerVC!.callbackDelegate = self
            navigationController?.pushViewController(newControl.controlFlowPickerVC!, animated: true)
        }
    }
    
    func objIsReady(tup : (NSIndexPath,Any)?)
    {
        callbackDelegate?.objIsReady(tup)
        navigationController?.popViewControllerAnimated(true)
    }

    
}
