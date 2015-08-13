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
    var titleLabelText : String? = nil
    var textLabelText : String? = nil

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textText: UITextView!
    
    override func viewDidLoad() {
        if respondsToSelector("edgesForExtendedLayout"){
            edgesForExtendedLayout = UIRectEdge.None
        }
        
        if(titleHint != nil)
        {
            titleText.placeholder = titleHint
        }
        if(titleLabelText != nil)
        {
            titleLabel.text = titleLabelText
        }
        if(textLabelText != nil)
        {
            textLabel.text = textLabelText
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "saveTexts")
    }
    
    func saveTexts()
    {
        let tup : (String, String) = (titleText.text, textText.text)
        callbackDelegate!.objIsReady((indexPath!, tup))
        navigationController?.popViewControllerAnimated(true)
    }
    
    func setNewTitle(newTitle : String)
    {
        title = newTitle
    }
}