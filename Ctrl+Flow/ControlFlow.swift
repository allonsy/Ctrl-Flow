
//
//  ControlFlow.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/30/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation
import UIKit

class ControlFlow : Executable
{
    var condition : Condition = Condition()
    var actions : ActionSequence = ActionSequence()
    var controlFlowPickerVC : CFViewController?
    var executeBlock : () -> Bool = {() -> Bool in return true}
    var name = "Control Flow"
    
    func execute() -> Bool {
        return executeBlock()
    }
    
    func getName() -> String
    {
        return name
    }
    
}

struct ControlFlowWrapper
{
    let name : String
    let description : String
    let returnControlFlow : () -> ControlFlow
    
    init(name : String, description : String, returnControlFunc : () -> ControlFlow)
    {
        self.name = name
        self.description = description
        self.returnControlFlow = returnControlFunc
    }
}

/* Control flow takes a condition and executes a series of actions based on that condition
Essentially, in the executeBlock, the control flow executes the condition.executeBlock code and checks if the results are nil or not
then, it conditionally executes the array of actions given

For more complicated flows, the programmer can create a custom VC to choose conditions and actions, when the control flow object is ready,
call the objIsReady function of the delegate of the control flow. If controlFlowPickerVC is non-nil ctrl-flow will give it the proper delegate

actions return true on success and false on failure, it is the job of the control flow to check for errors and deal with it appropriately (may call ctrl-flows error logging functions)
then, when all commands have completed to the satisfaction of the ctrl flow instance, it return true or false since a control flow is an action itself which allows arbitrary nesting
of actions

see Action.swift for examples on how to wrap this into the ControlFlowWrapper struct */
