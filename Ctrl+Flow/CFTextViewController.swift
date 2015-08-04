//
//  CFTextViewController.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/3/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class CFTextViewController: CFViewController
{
    var hintText : String? = nil
    @IBOutlet weak var entryTextField: UITextField!
    
    override func viewDidLoad() {
        entryTextField.placeholder = hintText
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "saveText")
    }
    
    func saveText()
    {
        callbackDelegate!.objIsReady((indexPath!,entryTextField.text))
        navigationController?.popViewControllerAnimated(true)
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
