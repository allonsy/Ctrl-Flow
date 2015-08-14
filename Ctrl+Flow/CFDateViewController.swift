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
        let timeInterval = floor(date.date.timeIntervalSinceReferenceDate / 60.0) * 60.0
        var FlooredDate = NSDate(timeIntervalSinceReferenceDate: timeInterval)
        callbackDelegate!.objIsReady((indexPath!, FlooredDate))
        navigationController?.popViewControllerAnimated(true)
    }
}

