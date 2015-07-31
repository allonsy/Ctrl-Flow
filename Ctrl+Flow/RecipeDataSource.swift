//
//  RecipeDataSource.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/31/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class RecipeDataSource : NSObject,UITableViewDataSource {
    
    //var recipes = [Recipe]()
    var recipes = [Recipe(name: "Hello", actions: [Executable](), continuous: false)]
    
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return getCellForRecipe(recipes[indexPath.indexAtPosition(1)])
    }
    
    func getCellForRecipe(rec : Recipe) -> UITableViewCell
    {
        let retCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "recipeCell")
        retCell.textLabel!.text = rec.name
        return retCell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            recipes.removeAtIndex(indexPath.indexAtPosition(1));
        }
    }
}
