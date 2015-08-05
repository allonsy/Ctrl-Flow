//
//  Actions.swift
//  Ctrl+Flow
//
//  Created by Alex Maeda on 8/4/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation
import AVFoundation

let flashOnFunc =
{ () -> Action in
    let flashAct = Action()
    flashAct.name = "Flashlight"
    flashAct.executeBlock = { (_ : Any?) -> Bool in
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device.hasTorch) {
            //probably should return false if we can't lock the device for configuration
            device.lockForConfiguration(nil)
            if (device.torchMode == AVCaptureTorchMode.On) {
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
let flashOnWrap = ActionWrapper(name:"Flashlight",
    description:"Turns on flashlight",
    returnActionFunc:flashOnFunc)

let flashOffFunc =
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

