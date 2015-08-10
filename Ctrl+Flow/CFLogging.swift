//
//  CFLogging.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/10/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class CFLogging
{
    private var log : [String]
    
    init()
    {
        log = []
    }
    
    init(log : [String])
    {
        self.log = log
    }
    
    func appendToLog(toAdd : String)
    {
        log.append(toAdd)
    }
    
    func dumpLog()
    {
        print("log : \(log)")
    }
    
    func notificationLog(toShow : String)
    {
        let notify = UILocalNotification()
        notify.alertBody = toShow
        notify.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().presentLocalNotificationNow(notify)
    }
    
    func showAlertWithText(text : String, viewController : UIViewController)
    {
        let alert = UIAlertController(title: "CTRL+Flow", message: text, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
}
