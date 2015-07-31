//
//  RecipeViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/31/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController {
    
    let recipeSource = RecipeDataSource()
    
    override func loadView()
    {
        self.tableView = UITableView()
        self.tableView.dataSource = recipeSource
    }
    
    override func viewDidLoad() {
        self.title = NSLocalizedString("RecipeVC-title", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addRecipe")
    }
    
    func addRecipe()
    {
        print("hello")
    }

}
