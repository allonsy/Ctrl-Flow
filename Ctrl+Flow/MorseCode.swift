//
//  MorseCode.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/13/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit
import AVFoundation

private let dot : Double = 0.1
private let dash : Double = dot * 3.0
private let intensity : Float = 0.25

private enum Morse
{
    case Dot
    case Dash
}

private func turnOnFlashlight()
{
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    if (device.hasTorch) {
        //probably should return false if we can't lock the device for configuration
        device.lockForConfiguration(nil)
        device.setTorchModeOnWithLevel(intensity, error: nil)
        device.unlockForConfiguration()
    }
}

private func turnOffFlashlight()
{
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    if (device.hasTorch) {
        //probably should return false if we can't lock the device for configuration
        device.lockForConfiguration(nil)
        if (device.torchMode == AVCaptureTorchMode.On) {
            device.torchMode = AVCaptureTorchMode.Off
        }
        device.unlockForConfiguration()
    }

}

private func morseFlash(item : Morse)
{
    if(item == Morse.Dot)
    {
        turnOnFlashlight()
        NSThread.sleepForTimeInterval(dot)
        turnOffFlashlight()
    }
    else
    {
        turnOnFlashlight()
        NSThread.sleepForTimeInterval(dash)
        turnOffFlashlight()
    }
}

private func encodeMorseForCharacter(char : Character) -> [Morse]
{
    switch(char) {
    
    case "a","A":
        return [.Dot, .Dash]
    case "b", "B":
        return [.Dash, .Dot, .Dot, .Dot]
    case "c","C":
        return [.Dash, .Dot, .Dash, .Dot]
    case "d", "D":
        return [.Dash, .Dot, .Dot]
    case "e","E":
        return [.Dot]
    case "f", "F":
        return [.Dot, .Dot, .Dash, .Dot]
    case "g","G":
        return [.Dash, .Dash, .Dot]
    case "h", "H":
        return [.Dot, .Dot, .Dot, .Dot]
    case "i","I":
        return [.Dot, .Dot]
    case "j", "J":
        return [.Dot, .Dash, .Dash, .Dash]
    case "k","K":
        return [.Dot, .Dash, .Dot, .Dot]
    case "l", "L":
        return [.Dash, .Dot, .Dot]
    case "m","M":
        return [.Dash, .Dash]
    case "n", "N":
        return [.Dash, .Dot]
    case "o","O":
        return [.Dash, .Dash, .Dash]
    case "p", "P":
        return [.Dot, .Dash, .Dash, .Dot]
    case "q","Q":
        return [.Dash, .Dash, .Dot, .Dash]
    case "r", "R":
        return [.Dot, .Dash, .Dot]
    case "s","S":
        return [.Dot, .Dot, .Dot]
    case "t", "T":
        return [.Dash]
    case "u","U":
        return [.Dot, .Dot, .Dash]
    case "v", "V":
        return [.Dot, .Dot, .Dot, .Dash]
    case "w","W":
        return [.Dot, .Dash, .Dash]
    case "x", "X":
        return [.Dash, .Dot, .Dot, .Dash]
    case "y", "Y":
        return [.Dash, .Dot, .Dash, .Dash]
    case "z", "Z":
        return [.Dash, .Dash, .Dot, .Dot]
    default:
        return [.Dot, .Dot, .Dot, .Dot]
    }
}

private func flashCharacter(char : Character)
{
    let encoding = encodeMorseForCharacter(char)
    for morse in encoding
    {
        morseFlash(morse)
        NSThread.sleepForTimeInterval(dot)
    }
}

private func flashString(toFlash : String)
{
    for var i = toFlash.startIndex ; i < toFlash.endIndex ; i=i.successor()
    {
        if(i.successor() == toFlash.endIndex)
        {
            flashCharacter(toFlash[i])
            return
        }
        
        let next = toFlash[i.successor()]
        
        if(next == " ")
        {
            flashCharacter(toFlash[i])
            NSThread.sleepForTimeInterval(dot*7)
            i++
        }
        else
        {
            flashCharacter(toFlash[i])
            NSThread.sleepForTimeInterval(dot*3)
        }
    }
}

private func returnMorseCodeAction() -> Action
{
    let retAction = Action()
    retAction.name = {(arg : Any?) -> String in
        if (arg == nil) {
            return "Morse code that item"
        }
        return "Morse codify: " + (arg as! String)
    }
    retAction.argumentPickerVC = CFTextViewController(nibName:"CFTextViewController", bundle:nil)
    retAction.argumentPickerVC?.title = "Enter Text"
    (retAction.argumentPickerVC! as! CFTextViewController).hintText = "enter text here"
    (retAction.argumentPickerVC! as! CFTextViewController).defaultReturn = ""
    
    func flashMorseAction (arg : Any?, argList : [Any?]) -> Bool
    {
        var toFlash : String = "SOS "
        if arg != nil
        {
            if(arg! is String)
            {
                toFlash = arg! as! String
            }
        }
        else if argList.count > 0
        {
            if(argList[0] != nil)
            {
                if argList[0]! is String
                {
                    toFlash = argList[0]! as! String
                }
            }
        }
        flashString(toFlash)
        return true
    }
    retAction.executeBlock = flashMorseAction
    return retAction
}
let morseActionWrap = ActionWrapper(name: "Morse Code that item", description: "Morse flash the item being passed in", returnActionFunc: returnMorseCodeAction)
