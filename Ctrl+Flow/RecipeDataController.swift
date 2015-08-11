//
//  RecipeDataSource.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/31/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class RecipeDataController : NSObject,UITableViewDataSource,UITableViewDelegate {
    
    //var recipes = [Recipe]()
    var recipes = [Recipe(name: "Hello everyone in the world", actions: [returnHello()], continuous: false)]
    var navigationController : UINavigationController? = nil
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return recipes.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        return getCellForRecipe(recipes[indexPath.indexAtPosition(1)])
    }
    
    func getCellForRecipe(rec : Recipe) -> UITableViewCell
    {
        let retCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "recipeCell")
        retCell.textLabel!.text = rec.name
        if(rec.continuous)
        {
            let activateSwitch = CFRecipeSwitch(rec: rec)
            activateSwitch.on = rec.activated
            activateSwitch.addTarget(self, action: "toggleRecipeOn:", forControlEvents: UIControlEvents.TouchUpInside)
            retCell.accessoryView = activateSwitch
        }
        else
        {
            let runButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            runButton.setTitle("Run", forState:UIControlState.Normal)
            runButton.addTarget(self, action: "toggleRecipeOn:", forControlEvents: UIControlEvents.TouchUpInside)
            runButton.frame = CGRectMake(0, 0, 51.0, 31.0)
            retCell.accessoryView = runButton
        }
        return retCell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            recipes.removeAtIndex(indexPath.indexAtPosition(1));
        }
    }
    
    func toggleRecipeOn(sender : AnyObject)
    {
        if let senderButton = sender as? UIButton
        {
            let tableView = RecipeDataController.getTableViewForCell(senderButton.superview!)!
            let cellIndex = tableView.indexPathForCell(senderButton.superview! as! UITableViewCell)!
            let newThread = NSThread(target: self, selector: "oneShotExecute:", object: recipes[cellIndex.row])
            newThread.start()
            return
        }
        let senderSwitch = sender as! CFRecipeSwitch
        let rec = senderSwitch.thisRecipe
        if(rec.thread == nil)
        {
            if(rec.continuous)
            {
                let newThread = NSThread(target: self, selector: "continuousExecute:", object: rec)
                newThread.start()
                rec.activated = true
                rec.thread = newThread
            }
        }
        else
        {
            if(rec.continuous)
            {
                rec.thread!.cancel()
                rec.thread = nil
            }
        }
    }
    
    func continuousExecute(sender : AnyObject?)
    {
        let rec = sender as! Recipe
        while(true)
        {
            rec.execute()
            if(NSThread.currentThread().cancelled)
            {
                NSThread.exit()
            }
        }
    }
    
    func oneShotExecute(sender : AnyObject?)
    {
        let rec = sender as! Recipe
        rec.execute()
        rec.thread = nil
    }
    
    class func getTableViewForCell(child : UIView) -> UITableView?
    {
        var parent : UIView = child
        while(!(parent is UITableView))
        {
            if(parent.superview == nil)
            {
                return nil
            }
            parent = parent.superview!
        }
        return parent as! UITableView
    }
}

private func returnHello() -> Action
{
    let helloEveryoneAction = Action()
    func notifyHello(Any?, [Any?]) -> Bool
    {
        CFGlobal.logger.notificationLog("Hello Everyone")
        return true
    }
    helloEveryoneAction.executeBlock = notifyHello
    helloEveryoneAction.name = "Hello Everyone In The World"
    return helloEveryoneAction
}
