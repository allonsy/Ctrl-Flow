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
        self.tableView = UITableView()
        self.tableView.delegate = self
        self.tableView.dataSource = dataController
    }
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedControl = dataController.controlFlows[indexPath.row]
        let newControl = selectedControl.returnControlFlow()
        if(newControl.controlFlowPickerVC == nil)
        {
            let editCFVC = EditControlFlowTableViewController()
            editCFVC.thisControl = newControl
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
        navigationController?.popViewControllerAnimated(true)
        callbackDelegate?.objIsReady(tup)
    }

    
}
