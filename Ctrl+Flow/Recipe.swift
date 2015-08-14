//
//  Recipe.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/31/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation

class Recipe : Executable
{
    var name : String
    var actions : [Executable]
    var continuous : Bool
    var activated : Bool
    var thread : NSThread?
    
    init(name : String, actions: [Executable], continuous : Bool)
    {
        self.name = name
        self.actions = actions
        self.continuous = continuous
        self.activated = false
    }
    
    func execute() -> Bool
    {
        map_({ (obj : Executable) -> () in obj.execute()}, actions)
        return true
    }
    func getName() -> String
    {
        return name
    }
    
    func addArgument(p: Any?) {
        for action in actions{
            action.addArgument(p)
        }
    }
}

/* Recipe represents a sequence of Actions
executes each action in sequence
if continuous is true, it will repeat the sequence forever until halted
otherwise, it has one-shot behavior
*/