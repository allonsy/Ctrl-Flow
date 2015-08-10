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

class Actions {
    static let flashOnFunc =
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
    static let flashOn = ActionWrapper(name:"Flashlight ON",
        description:"Turns on flashlight",
        returnActionFunc:flashOnFunc)
    
    static let flashOffFunc =
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
    static let flashOff = ActionWrapper(name:"Flashlight OFF",
        description:"Turns on flashlight",
        returnActionFunc:flashOffFunc)
    
    
    static let callFunc =
    { () -> Action in
        let callAct = Action()
        callAct.name = "Call"
        callAct.executeBlock = { (url: Any?) -> Bool in
            let phone_url:NSURL = NSURL(string: url as! String)!;
            return UIApplication.sharedApplication().openURL(phone_url)
        }
        return callAct
    }
    static let call = ActionWrapper(name:"Call",
        description:"Uses phone to call phone number",
        returnActionFunc:callFunc)
    
    static let notificationFunc =
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
    static let notification = ActionWrapper(name:"Notification",
        description:"Calls a notification",
        returnActionFunc: notificationFunc)
    
}


