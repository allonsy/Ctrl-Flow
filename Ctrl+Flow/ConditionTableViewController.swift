//
//  ConditionTableViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/4/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class ConditionTableViewController: UITableViewController,CallbackWhenReadyDelegate
{
    var callbackDelegate : CallbackWhenReadyDelegate? = nil
    let dataController =  ConditionDataController()
    
    override func loadView() {
        tableView = UITableView()
        tableView.dataSource = dataController
        tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pick a Condition"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedCondition = dataController.conditions[indexPath.row]
        let newCondition = selectedCondition.returnCondition()
        if(newCondition.argumentPickerVC == nil)
        {
            objIsReady(newCondition)
        }
        else
        {
            newCondition.argumentPickerVC!.callbackDelegate = self
            navigationController?.pushViewController(newCondition.argumentPickerVC!, animated: true)
        }
    }
    
    func objIsReady(ret: Any?)
    {
        callbackDelegate?.objIsReady(ret)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
}
