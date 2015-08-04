//
//  RecipeViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/31/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController,CallbackWhenReadyDelegate {
    
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
        self.navigationController?.pushViewController(editRecipeVC, animated: true)
    }
    
    func objIsReady(ret : Any?) {
        if(ret != nil)
        {
            recipeSource.recipes.append(ret as! Recipe)
        }
        self.tableView.reloadData()
    }
}
