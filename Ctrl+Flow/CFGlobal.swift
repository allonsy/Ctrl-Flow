//
//  CFGlobal.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/3/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation


class CFGlobal
{
    static let conditions : [ConditionWrapper] = [CFGlobal.alarmWrap]
    static let actions : [ActionWrapper] = [CFGlobal.flashwrap2, CFGlobal.flashwrap]
    static let controls : [ControlFlowWrapper] = [CFGlobal.ifelseWrap]
    
    
    // This condition returns true if the current time is after the
    // time given
    static let alarmCondition =
    { () -> Condition in
        let alarmCond = Condition()
        alarmCond.name = "alarm"
        alarmCond.executeBlock = { (time: Any?) -> Any? in
            if time == nil {
                return false
            }
            let currentTime = NSDate()
            switch currentTime.compare(time as! NSDate){
            case .OrderedDescending:
                return true
            default:
                return nil
            }
        }
        return alarmCond
    }
    static let alarmWrap = ConditionWrapper(name:"Alarm Condition",
                                     description:"returns true if past the time given",
                                     returnConditionFunc: alarmCondition)

    static let flashlightAction =
    { () -> Action in
        let flashAct = Action()
        flashAct.name = "Flashlight"
        flashAct.executeBlock = { (_ : Any?) -> Bool in
            let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            if (device.hasTorch) {
                //probably should return false if we can't lock the device for configuration
                device.lockForConfiguration(nil)
                if (device.torchMode == AVCaptureTorchMode.On) {
                    device.torchMode = AVCaptureTorchMode.Off
                } else {
                    device.setTorchModeOnWithLevel(1.0, error: nil)
                }
                device.unlockForConfiguration()
                return true
            }
            return false
        }
        return flashAct
    }
    static let flashwrap = ActionWrapper(name:"Flashlight",
                                  description:"Turns on flashlight",
                                  returnActionFunc:flashlightAction)
    //test
    static let flashlightAction2 =
    { () -> Action in
        let flashAct = Action()
        flashAct.name = "Flashlight2"
        flashAct.executeBlock = { (_ : Any?) -> Bool in
            let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            if (device.hasTorch) {
                //probably should return false if we can't lock the device for configuration
                device.lockForConfiguration(nil)
                if (device.torchMode == AVCaptureTorchMode.On) {
                    device.torchMode = AVCaptureTorchMode.Off
                } else {
                    device.setTorchModeOnWithLevel(1.0, error: nil)
                }
                device.unlockForConfiguration()
                return true
            }
            return false
        }
        return flashAct
    }

    
    static let flashwrap2 = ActionWrapper(name:"Flashlight2",
        description:"Turns on flashlight2",
        returnActionFunc:flashlightAction2)

    //end test
    
    static let ifelseControlFlow =
    { () -> ControlFlow in
        let ifelseCF = ControlFlow()
        ifelseCF.name = "If/Else"
        ifelseCF.executeBlock = { (condition: Condition, actions: ActionSequence) -> Bool in
            if actions.count < 2{
                return false
            }
            if (condition.getCondition() as! Bool) {
                actions[0].execute()
            } else {
                actions[1].execute()
            }
            return true
        }
        return ifelseCF
    }
    static let ifelseWrap = ControlFlowWrapper(name: "if else Control Flow",
                                        description: "prototype if else Control Flow",
                                        returnControlFunc: ifelseControlFlow)
}
