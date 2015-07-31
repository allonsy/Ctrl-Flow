//
//  RecipeViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/31/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController {
    
    let recipeSource = RecipeDataController()
    
    override func loadView()
    {
        self.tableView = UITableView()
        self.tableView.dataSource = recipeSource
        self.tableView.delegate = recipeSource
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
        self.navigationController?.pushViewController(addRecipeVC, animated: true)
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.toolbarHidden = true
        super.viewWillAppear(animated)
    }

}
