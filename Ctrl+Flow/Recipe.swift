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
    let name : String
    let actions : [Executable]
    let continuous : Bool
    
    init(name : String, actions: [Executable], continuous : Bool)
    {
        self.name = name
        self.actions = actions
        self.continuous = continuous
    }
    
    func execute() -> Bool {
        if(continuous)
        {
            while true
            {
                map_({ (obj : Executable) -> () in obj.execute()}, actions)
            }
        }
        else
        {
            map_({ (obj : Executable) -> () in obj.execute()}, actions)
        }
        return true
    }
}

/* Recipe represents a sequence of Actions
executes each action in sequence
if continuous is true, it will repeat the sequence forever until halted
otherwise, it has one-shot behavior
*/