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


class Actions {
    static let flashOnFunc =
    { () -> Action in
        let flashAct = Action()
        
        flashAct.argumentPickerVC = CFTextViewController(nibName:"CFTextViewController", bundle:nil)
        flashAct.argumentPickerVC?.title = "Intensity"
        (flashAct.argumentPickerVC! as! CFTextViewController).hintText = "1.0"
        (flashAct.argumentPickerVC! as! CFTextViewController).defaultReturn = "1.0"
        flashAct.name = { (arg : Any?) -> String in
            if arg == nil {
                return "Flashlight ON"
            }
            return "Flashlight On - Intensity: " + (arg as! String)
        }
        flashAct.executeBlock = { (arg : Any?, _ : [Any?]) -> Bool in
            
            let num = (arg == nil) ? 1.0 : (arg! as! NSString).floatValue
            let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            if (device.hasTorch) {
                //probably should return false if we can't lock the device for configuration
                device.lockForConfiguration(nil)
                device.setTorchModeOnWithLevel(num, error: nil)
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
        flashAct.name = { (arg : Any?) -> String in
            return "Flashlight OFF"
        }
        flashAct.executeBlock = { (_ : Any?, _ : [Any?]) -> Bool in
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
        
        callAct.argumentPickerVC = CFTextViewController(nibName:"CFTextViewController", bundle:nil)
        callAct.argumentPickerVC?.title = "Phone Number"
        (callAct.argumentPickerVC! as! CFTextViewController).hintText = "Phone Number"
        callAct.name = { (arg : Any?) -> String in
            if arg == nil {
                return "Call Number"
            }
            return "Call - " + (arg as! String)
        }

        callAct.executeBlock = { (number : Any?, _ : [Any?]) -> Bool in
            let url = "tel://" + (number as! String)
            let phone_url:NSURL = NSURL(string: url)!;
            return UIApplication.sharedApplication().openURL(phone_url)
        }
        return callAct
    }
    static let call = ActionWrapper(name:"Call",
        description:"Uses phone to call phone number",
        returnActionFunc:callFunc)

    static let sleep = sleepAction
    static let notification = notificationAction
    static let morseThat = morseActionWrap
    static let morseUserInput = morseCodeUserInputWrap
    static let vibrate = ActionWrapper(name: "Vibrate", description: "Vibrate the device", returnActionFunc: returnEmptyAction)
    static let uber = ActionWrapper(name: "Uber", description: "Call and Uber", returnActionFunc: returnEmptyAction)
    static let sendText = ActionWrapper(name: "text", description: "Send a text", returnActionFunc: returnEmptyAction)
    static let sendEmail = ActionWrapper(name: "Email", description: "Send an email", returnActionFunc: returnEmptyAction)
    static let worldPeace = ActionWrapper(name: "Create World Peace", description: "nuff said", returnActionFunc: returnEmptyAction)
    static let mineBitcoin = ActionWrapper(name: "Mine Bitcoin", description: "make me rich", returnActionFunc: returnEmptyAction)
}
private func returnEmptyAction() -> Action
{
    return Action()
}


