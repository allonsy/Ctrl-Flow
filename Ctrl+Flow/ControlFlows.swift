//
//  ControlFlows.swift
//  Ctrl+Flow
//
//  Created by Alex Maeda on 8/4/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation

class ControlFlows{
    static let  ifControlFunc =
    { () -> ControlFlow in
        let ifCF = ControlFlow()
        ifCF.executeBlock = { (condition: Condition, actions: ActionSequence) -> Bool in
            if actions.count < 2{
                return false
            }
            //I don't like how we just take the first 2 elements of the actions, but we'll leave it for now
            //Can we make it so we have the if condition actions on the evens, and the else condition on the odds?
            let conditionValue : Any? = condition.evaluate()
            if (conditionValue != nil) {
                for i in 0..<actions.count{
                    let action = actions[i] as! Action
                    action.conditionArgs.append(conditionValue)
                    action.execute()
                }
            }
            return true
        }
        return ifCF
    }
    static let ifControl = ControlFlowWrapper(name: "if",
        description: "if Control Flow",
        returnControlFunc: ifControlFunc)
    
    static let loopWhileControlFunc =
    { () -> ControlFlow in
        let loopWhileControlFlow = ControlFlow()
        loopWhileControlFlow.executeBlock = { (condition: Condition, actions: ActionSequence) -> Bool in
            var conditionValue : Any? = condition.evaluate()
            while (conditionValue != nil){
                for i in 0..<actions.count{
                    let action = actions[i] as! Action
                    action.conditionArgs.append(conditionValue)
                    action.execute()
                }
                conditionValue = condition.evaluate()
            }
            return false
        }
        return loopWhileControlFlow
    }
    static let loopWhile = ControlFlowWrapper(name: "while loop",
        description: "while loop Control Flow",
        returnControlFunc: loopWhileControlFunc)
    
    static let loopUntilControlFunc =
    { () -> ControlFlow in
        let loopWhileControlFlow = ControlFlow()
        loopWhileControlFlow.executeBlock = { (condition: Condition, actions: ActionSequence) -> Bool in
            var conditionValue : Any? = condition.evaluate()
            while (conditionValue == nil){
                for i in 0..<actions.count{
                    let action = actions[i] as! Action
                    action.conditionArgs.append(conditionValue)
                    action.execute()
                }
                conditionValue = condition.evaluate()
            }
            return false
        }
        return loopWhileControlFlow
    }
    static let loopUntil = ControlFlowWrapper(name: "until loop",
        description: "until loop Control Flow",
        returnControlFunc: loopUntilControlFunc)
    
}
