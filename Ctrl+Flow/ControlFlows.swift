//
//  ControlFlows.swift
//  Ctrl+Flow
//
//  Created by Alex Maeda on 8/4/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation

let ifelseControlFunc =
{ () -> ControlFlow in
    let ifelseCF = ControlFlow()
    ifelseCF.executeBlock = { (condition: Condition, actions: ActionSequence) -> Bool in
        if actions.count < 2{
            return false
        }
        //I don't like how we just take the first 2 elements of the actions, but we'll leave it for now
        //Can we make it so we have the if condition actions on the evens, and the else condition on the odds?
        let conditionValue : Any? = condition.evaluate()
        if (conditionValue != nil) {
            for i in 0...actions.count{
                if (i % 2 == 0) {
                    let action = actions[i] as! Action
                    action.arg = conditionValue
                    action.execute()
                }
            }
        } else {
            for i in 0...actions.count{
                if (i % 2 == 1) {
                    let action = actions[i] as! Action
                    action.arg = conditionValue
                    action.execute()
                }
            }
        }
        return true
    }
    return ifelseCF
}
let ifelseWrap = ControlFlowWrapper(name: "if else Control Flow",
    description: "if else Control Flow",
    returnControlFunc: ifelseControlFunc)

let loopWhileControlFunc =
{ () -> ControlFlow in
    let loopWhileControlFlow = ControlFlow()
    loopWhileControlFlow.executeBlock = { (condition: Condition, actions: ActionSequence) -> Bool in
        var conditionValue : Any? = condition.evaluate()
        while (conditionValue != nil){
            for i in 0...actions.count{
                let action = actions[i] as! Action
                action.arg = conditionValue
                action.execute()
            }
            conditionValue = condition.evaluate()
        }
        return false
    }
    return loopWhileControlFlow
}
let loopWhileWrap = ControlFlowWrapper(name: "while loop Control Flow",
    description: "while loop Control Flow",
    returnControlFunc: loopWhileControlFunc)

let loopUntilControlFunc =
{ () -> ControlFlow in
    let loopWhileControlFlow = ControlFlow()
    loopWhileControlFlow.executeBlock = { (condition: Condition, actions: ActionSequence) -> Bool in
        var conditionValue : Any? = condition.evaluate()
        while (conditionValue == nil){
            for i in 0...actions.count{
                let action = actions[i] as! Action
                action.arg = conditionValue
                action.execute()
            }
            conditionValue = condition.evaluate()
        }
        return false
    }
    return loopWhileControlFlow
}
let loopUntilWrap = ControlFlowWrapper(name: "until loop Control Flow",
    description: "until loop Control Flow",
    returnControlFunc: loopUntilControlFunc)