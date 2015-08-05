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
    var callbackDelegate : CallbackWhenReadyDelegate? = nil
    var indexPath : NSIndexPath? = nil
    
    override func loadView() {
        tableView = UITableView()
        tableView.dataSource = dataController
        tableView.delegate = self
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Pick an Action"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let newAction = dataController.actions[indexPath.row].returnAction()
        if(newAction.argumentPickerVC == nil)
        {
            callbackDelegate?.objIsReady((self.indexPath!,newAction))
            self.navigationController?.popViewControllerAnimated(true)
        }
        else
        {
            newAction.argumentPickerVC!.callbackDelegate = self
            newAction.argumentPickerVC!.thisObj = newAction
            navigationController?.pushViewController(newAction.argumentPickerVC!, animated: true)
        }
    }
    
    func objIsReady(ret: (NSIndexPath,Any)?)
    {
        let (indexPath, retArg) = ret!
        let selectedAction = dataController.actions[indexPath.row].returnAction()
        selectedAction.arg = retArg
        callbackDelegate?.objIsReady((self.indexPath!,selectedAction))
        self.navigationController?.popViewControllerAnimated(true)
    }

}
