//
//  Notification.swift
//  Ctrl+Flow
//
//  Created by Alex Maeda on 8/12/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation
import MessageUI

private func retNotifAction () -> Action
{
    let retAction = Action()
    retAction.argumentPickerVC = CFTitleAndTextViewController(nibName:"CFTitleAndTextViewController", bundle:nil)
    (retAction.argumentPickerVC as! CFTitleAndTextViewController).titleLabelText = "Title: "
    (retAction.argumentPickerVC as! CFTitleAndTextViewController).textLabelText = "Body: "
    (retAction.argumentPickerVC as! CFTitleAndTextViewController).titleHint = "notification title"
    (retAction.argumentPickerVC as! CFTitleAndTextViewController).setNewTitle("Create New Notification")
    retAction.name = { (arg : Any?) -> String in
        if arg == nil {
            return "Notification"
        }
        let (title, _ ) = arg as! (String, String)
        println(title)
        return "Notification - " + title
    }
    
    func execute(arg : Any?, _ : [Any?]) -> Bool
    {
        var (title, body) = arg as! (String, String)
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertTitle = title
        localNotification.alertBody = body
        UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)
        return true
    }
    
    retAction.executeBlock = execute
    
    return retAction
}

let notificationAction = ActionWrapper(name: "Notification", description: "push a notification", returnActionFunc: retNotifAction)