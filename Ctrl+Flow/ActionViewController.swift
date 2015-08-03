//
//  ActionViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/3/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class ActionViewController: UITableViewController,CallbackWhenReadyDelegate
{
    let dataController = ActionDataController()
    let callbackDelegate : CallbackWhenReadyDelegate? = nil
    
    override func loadView() {
        tableView = UITableView()
        tableView.dataSource = dataController
        tableView.delegate = dataController
        
    }
    
    override func viewDidLoad() {
        self.title = "Pick an Action"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedAction = dataController.actions[indexPath.indexAtPosition(0)]
        let newAction = selectedAction.returnAction()
        if(newAction.argumentPickerVC == nil)
        {
            callbackDelegate?.objIsReady(newAction)
        }
        else
        {
            newAction.argumentPickerVC!.callbackDelegate = self
            navigationController?.pushViewController(newAction.argumentPickerVC!, animated: true)
        }
    }
    
    func objIsReady(ret: Any?)
    {
        callbackDelegate?.objIsReady(ret)
    }

}
