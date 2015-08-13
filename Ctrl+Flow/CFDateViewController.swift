//
//  CFDateViewController.swift
//  Ctrl+Flow
//
//  Created by Alex Maeda on 8/13/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class CFDateViewController: CFViewController
{
    
    @IBOutlet weak var date: UIDatePicker!
    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "saveDate")

    }
    
    func saveDate(){
        callbackDelegate!.objIsReady((indexPath!, date.date))
        navigationController?.popViewControllerAnimated(true)
    }
}

