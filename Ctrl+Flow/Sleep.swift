//
//  Sleep.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/10/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation

private func retSleepAction () -> Action
{
    let retAction = Action()
    retAction.argumentPickerVC = CFTextViewController(nibName:"CFTextViewController", bundle:nil)
    retAction.argumentPickerVC?.title = "How Many Seconds?"
    (retAction.argumentPickerVC! as! CFTextViewController).hintText = "1.0"
    retAction.name = "Sleep for x seconds"
    
    func execute(arg : Any?) -> Bool
    {
        if(arg == nil)
        {
            return true
        }
        let num = arg!
        if let numSleep = num as? Double
        {
            NSThread.sleepForTimeInterval(numSleep);
        }
        return true
    }
    
    retAction.executeBlock = execute
    
    return retAction
}

let sleepAction = ActionWrapper(name: "Sleep", description: "Pause for x seconds", returnActionFunc: retSleepAction)
