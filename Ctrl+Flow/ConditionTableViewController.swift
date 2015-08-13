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
    var indexPath : NSIndexPath? = nil
    
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
            callbackDelegate?.objIsReady((self.indexPath!,newCondition))
            self.navigationController?.popViewControllerAnimated(true)
        }
        else
        {
            newCondition.argumentPickerVC!.callbackDelegate = self
            newCondition.argumentPickerVC!.indexPath = indexPath
            newCondition.argumentPickerVC?.thisObj = newCondition
            navigationController?.pushViewController(newCondition.argumentPickerVC!, animated: true)
        }
    }
    
    func objIsReady(tup : (NSIndexPath,Any)?)
    {
        let (indexPath, ret) = tup!
        let selectedCondition = dataController.conditions[indexPath.row].returnCondition()
        selectedCondition.arg = ret
        callbackDelegate?.objIsReady((self.indexPath!, selectedCondition))
        self.navigationController?.popViewControllerAnimated(true)
    }
}
