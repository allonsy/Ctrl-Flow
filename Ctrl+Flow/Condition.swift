//
//  Condition.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/30/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation
import UIKit

class Condition
{
    var name = "Condition"
    var arg : Any? = nil
    var executeBlock : (Any?) -> Any? = { (_ : Any?) -> Any? in return nil }
    var argumentPickerVC : CFViewController?
    
    func getCondition () -> Any?
    {
        return executeBlock(arg)
    }
    
}

struct ConditionWrapper
{
    let name : String
    let description : String
    let returnCondition : () -> Condition
    
    init(name : String, description : String, returnConditionFunc : () -> Condition)
    {
        self.name = name
        self.description = description
        self.returnCondition = returnConditionFunc
    }
}

/* 
Largely similar to Action and ActionWrapper, see Action.swift for details
A Condition mainly has an executeBlock which takes in an optional argument and return an optional value
Use conditionals with control flow to tell the control flow what to execute
the executeBlock may block while it is waiting for events to occur (can be synchronous)
Generally, conditions should return nil to tell the control flow "false" however false can also be passed instead
(this is to avoid conflict with control flows that may treat false in a different way
It can take optional arguments as well. 
If the condition needs to pass a value to the control flow, place it as a non nil return in the execute block
it is the job of the control flow segment to deal with this value properly
*/
