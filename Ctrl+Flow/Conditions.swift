//
//  Conditions.swift
//  Ctrl+Flow
//
//  Created by Alex Maeda on 8/4/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation
import CoreTelephony
class Conditions{
    static let afterTimeFunc =
    { () -> Condition in
        let afterTimeCond = Condition()
        afterTimeCond.argumentPickerVC = CFDateViewController(nibName:"CFDateViewController", bundle:nil)
        afterTimeCond.argumentPickerVC?.title = "set time"
        afterTimeCond.name = "Alarm Condition"
        
        afterTimeCond.executeBlock = { (date_any: Any?) -> Any? in
            if date_any == nil {
                return nil
            }
            let time = (date_any as! NSDate)
            let currentTime = NSDate()
            
            switch currentTime.compare(time){
            case .OrderedDescending:
                return true
            case .OrderedSame:
                return true
            default:
                return nil
            }
        }
        return afterTimeCond
    }
    static let afterTime = ConditionWrapper(name:"Alarm Condition",
        description:"returns true if past the time given",
        returnConditionFunc: afterTimeFunc)

    static let beforeTimeFunc =
    { () -> Condition in
        let beforeTimeCond = Condition()
        beforeTimeCond.argumentPickerVC = CFDateViewController(nibName:"CFDateViewController", bundle:nil)
        beforeTimeCond.argumentPickerVC?.title = "set time"
        beforeTimeCond.name = "Alarm Condition"
        beforeTimeCond.executeBlock = { (date_any: Any?) -> Any? in
            if date_any == nil {
                return nil
            }
            let time = (date_any as! NSDate)
            let currentTime = NSDate()
            switch currentTime.compare(time){
            case .OrderedAscending:
                return true
            default:
                return nil
            }
        }
        return beforeTimeCond
    }
    static let beforeTime = ConditionWrapper(name:"Alarm Condition",
        description:"returns true if before the time given",
        returnConditionFunc: Conditions.beforeTimeFunc)

    static let trueFunc =
    { () -> Condition in
        let trueCond = Condition()
        trueCond.name = "true"
        trueCond.executeBlock = { (_: Any?) -> Any? in
            return true
        }
        return trueCond
    }
    static let trueCondition = ConditionWrapper(name:"True Condition",
        description:"returns true",
        returnConditionFunc: Conditions.trueFunc)

    static let falseFunc =
    { () -> Condition in
        let falseCond = Condition()
        falseCond.name = "false"
        falseCond.executeBlock = { (_: Any?) -> Any? in
            return nil
        }
        return falseCond
    }
    static let falseCondition = ConditionWrapper(name:"False Condition",
        description:"returns false",
        returnConditionFunc:Conditions.beforeTimeFunc)

    static let numberFunc =
    { () -> Condition in
        let numberCond = Condition()
        numberCond.argumentPickerVC = CFTextViewController(nibName:"CFTextViewController", bundle:nil)
        numberCond.argumentPickerVC?.title = "How many times?"
        (numberCond.argumentPickerVC! as! CFTextViewController).hintText = "1"
        (numberCond.argumentPickerVC! as! CFTextViewController).defaultReturn = "1"
        numberCond.name = "Number Condition"
       
        var stack = numberCond.stack
        numberCond.executeBlock = { (number: Any?) -> Any? in
            if (stack.count == 0){
                var num = (number as! String).toInt()!
                println(num)
                if (num == 0){
                    return nil
                }
                var next_num = num - 1
                stack.append(next_num)
                return true
            }
            else {
                var num = stack.removeAtIndex(0) as! Int
                println(num)
                if (num <= 0){
                    stack.append(0)
                    return nil
                }
                var next_num = num - 1
                stack.append(next_num)
                return true
            }
        }
        return numberCond
    }
    static let number = ConditionWrapper(name:"Number Condition",
        description:"returns true n times, then returns false",
        returnConditionFunc: numberFunc)

    static let inCallFunc =
    { () -> Condition in
        let inCallCond = Condition()
        inCallCond.name = "In Call"
        inCallCond.executeBlock = { (_: Any?) -> Any? in
            var callCenter = CTCallCenter()
            let calls = callCenter.currentCalls
            if calls.isEmpty {
                return nil
            }
            return calls.first
        }
        return inCallCond
    }
    static let inCall = ConditionWrapper(name:"In Call Condition",
        description:"returns true if receiving a call, else returns false",
        returnConditionFunc: beforeTimeFunc)
    static let receiveGmail = receiveGmailCondititon
}
