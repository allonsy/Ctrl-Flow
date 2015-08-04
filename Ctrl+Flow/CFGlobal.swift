//
//  CFGlobal.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/3/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class CFGlobal
{
    static let conditions : [ConditionWrapper] = []
    static let actions : [ActionWrapper] = [CFGlobal.flashwrap]
    static let controls : [ControlFlowWrapper] = []
    
    
    // This condition returns true if the current time is after the
    // time given
    static let alarmCondition =
    { () -> Condition in
        let alarmCond = Condition()
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
    let alarmWrap = ConditionWrapper(name:"Alarm Condition",
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
    
    static let ifelseControlFlow =
    { () -> ControlFlow in
        let ifelseCF = ControlFlow()
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
    let ifelseWrap = ControlFlowWrapper(name: "if else Control Flow",
                                        description: "prototype if else Control Flow",
                                        returnControlFunc: ifelseControlFlow)
    
    
    
}
