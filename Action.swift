//
//  Action.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/30/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation
import UIKit

class Action : Executable
{
    var arg : Any? = nil
    var conditionArgs : [Any?] = [Any?]()
    var executeBlock : (Any?, [Any?]) -> Bool = { (_ : Any?, _ : [Any?]) -> Bool in return true }
    var argumentPickerVC : CFViewController?
    
    var name = "Action"
    
    func execute() -> Bool
    {
        return executeBlock(arg, conditionArgs)
    }
    
    func getName() -> String
    {
        return name
    }
}

struct ActionWrapper
{
    let name : String
    let description : String
    let returnAction : () -> Action
    
    init(name : String, description : String, returnActionFunc : () -> Action)
    {
        self.name = name
        self.description = description
        self.returnAction = returnActionFunc
    }
}

/* Describes an action which is just an executable block with optional arguments
the argument Picker is a VC that allows the user to choose custom arguments, may be nil
It is up to the programmer, not ctrl flow to create this VC
Once the user has chosen arguments and the action object has it's arguments all formatted in place, the VC tells CTRL-flow
that this action is ready to be used by calling the objIsReady() function of the delegate. If controlFlowPickerVC is non-nil ctrl-flow will give it the proper delegate

An action wrapper wraps an action up with metadata and provides a function that is an action generator
the returnAction function should spit out new Action instances every time based of a certain blueprint:

for example:

func flashlightAction() -> Action
{
    let flashAct = Action()
    flashAct.executeBlock = { (_ : Any?) -> Bool in
        //turn on flashlight code
        return true
        //if flashlight turn on fails, return false instead
    }
    return flashAct
}
let awrap = ActionWrapper(name:"Flashlight", description:"Turns on flashlight", returnActionFunc:flashlightAction)

Now, awrap is passable to ctrl-flow */