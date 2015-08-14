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
        ifCF.name = "If Block"
        ifCF.executeBlock = { (condition: Condition, actions: ActionSequence) -> Bool in
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
        loopWhileControlFlow.name = "While"
        loopWhileControlFlow.executeBlock = { (condition: Condition, actions: ActionSequence) -> Bool in
            var conditionValue : Any? = condition.evaluate()
            while (conditionValue != nil){
                if(NSThread.currentThread().cancelled)
                {
                    NSThread.exit()
                }
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
        loopWhileControlFlow.name = "Until Block"
        loopWhileControlFlow.executeBlock = { (condition: Condition, actions: ActionSequence) -> Bool in
            var conditionValue : Any? = condition.evaluate()
            while (conditionValue == nil){
                if(NSThread.currentThread().cancelled)
                {
                    NSThread.exit()
                }
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
