//
//  CFSectionHeaderView.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/11/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

func getCFCustomSectionHeaderView(tableView : UITableView, #title : String, #buttonTitle : String, #target : UIViewController, #selector : Selector, #height : CGFloat) -> UITableViewHeaderFooterView
{
    let retView = UITableViewHeaderFooterView()
    let width = CGRectGetWidth(tableView.frame)
    let magicNumber = 3.0
    let ypos = 0.0
    let totalHeight = CGFloat(Double(height) - ypos)
    let totalWidth = CGFloat(50.0)
    let xpos = Double(width) - Double(totalWidth) - magicNumber
    retView.textLabel.text = title
    let editButton : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    editButton.frame = CGRectMake(CGFloat(xpos), CGFloat(ypos), totalWidth, totalHeight)
    editButton.clipsToBounds = true
    editButton.setTitle(buttonTitle, forState: UIControlState.Normal)
    editButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
    editButton.addTarget(target, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
    retView.contentView.addSubview(editButton)
    return retView

}