//
//  Actions.swift
//  Ctrl+Flow
//
//  Created by Alex Maeda on 8/4/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import MessageUI

let flashOnFunc =
{ () -> Action in
    let flashAct = Action()
    flashAct.name = "Flashlight ON"
    flashAct.executeBlock = { (_ : Any?) -> Bool in
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device.hasTorch) {
            //probably should return false if we can't lock the device for configuration
            device.lockForConfiguration(nil)
            if (device.torchMode != AVCaptureTorchMode.On){
                device.setTorchModeOnWithLevel(1.0, error: nil)
            }
            device.unlockForConfiguration()
            return true
        }
        return false
    }
    return flashAct
}
let flashOnWrap = ActionWrapper(name:"Flashlight",
    description:"Turns on flashlight",
    returnActionFunc:flashOnFunc)

let flashOffFunc =
{ () -> Action in
    let flashAct = Action()
    flashAct.name = "Flashlight OFF"
    flashAct.executeBlock = { (_ : Any?) -> Bool in
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device.hasTorch) {
            //probably should return false if we can't lock the device for configuration
            device.lockForConfiguration(nil)
            if (device.torchMode == AVCaptureTorchMode.On) {
                device.torchMode = AVCaptureTorchMode.Off
            }
            device.unlockForConfiguration()
            return true
        }
        return false
    }
    return flashAct
}
let flashOffWrap = ActionWrapper(name:"Flashlight",
    description:"Turns on flashlight",
    returnActionFunc:flashOffFunc)


let callFunc =
{ () -> Action in
    let callAct = Action()
    callAct.name = "Call"
    callAct.executeBlock = { (url: Any?) -> Bool in
        let phone_url:NSURL = NSURL(string: url as! String)!;
        return UIApplication.sharedApplication().openURL(phone_url)
    }
    return callAct
}
let callWrap = ActionWrapper(name:"Call",
    description:"Uses phone to call phone number",
    returnActionFunc:callFunc)

let notificationFunc =
{ () -> Action in
    let notificationAct = Action()
    notificationAct.name = "Notification"
    notificationAct.executeBlock = { (any_tuple: Any?) -> Bool in
        var (title, body) = any_tuple as! (String, String)
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = title
        localNotification.alertBody = body
        UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)
        return true
    }
    return notificationAct
}
let notificationWrap = ActionWrapper(name:"Notification",
    description:"Calls a notification",
    returnActionFunc:callFunc)

let emailFunc =
{ () -> Action in
    let emailAct = Action()
    
    return emailAct
}




