//
//  CFTitleAndTextViewController.swift
//  Ctrl+Flow
//
//  Created by Alex Maeda on 8/11/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class CFTitleAndTextViewController: CFViewController
{
    
    var titleHint : String? = nil

    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        if(titleHint != nil)
        {
            titleField.placeholder = titleHint
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "saveTexts")
    }
    
    func saveTexts()
    {
        callbackDelegate!.objIsReady((indexPath!,(textField.text, titleField.text)))
        navigationController?.popViewControllerAnimated(true)
    }
    
    func setNewTitle(newTitle : String)
    {
        title = newTitle
    }
}