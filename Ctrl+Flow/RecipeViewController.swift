//
//  RecipeViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/31/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController,CallbackWhenReadyDelegate
{
    
    let recipeSource = RecipeDataController()
    
    override func loadView()
    {
        self.tableView = UITableView()
        self.tableView.dataSource = recipeSource
        self.tableView.delegate = self
        recipeSource.navigationController = self.navigationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("RecipeVC-title", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addRecipe")
    }
    
    func addRecipe()
    {
        let addRecipeVC = EditRecipeViewController()
        addRecipeVC.indexPath = NSIndexPath(forRow: recipeSource.recipes.count, inSection: 0)
        addRecipeVC.callBackDelegate=self
        self.navigationController?.pushViewController(addRecipeVC, animated: true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.toolbarHidden = true
        super.viewWillAppear(animated)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedRecipe = recipeSource.recipes[indexPath.indexAtPosition(1)]
        let editRecipeVC = EditRecipeViewController()
        editRecipeVC.thisRecipe = selectedRecipe
        editRecipeVC.vcTitle = "Edit Recipe: " + selectedRecipe.getName()
        editRecipeVC.callBackDelegate = self
        editRecipeVC.indexPath = indexPath
        self.navigationController?.pushViewController(editRecipeVC, animated: true)
    }
    
    func objIsReady(tup : (NSIndexPath,Any)?) {
        if(tup != nil)
        {
            let (indexPath, ret) = tup!
            if(indexPath.row == recipeSource.recipes.count)
            {
                recipeSource.recipes.append(ret as! Recipe)
            }
            else
            {
                recipeSource.recipes[indexPath.row] = ret as! Recipe
            }
        }
        self.tableView.reloadData()
    }
}
