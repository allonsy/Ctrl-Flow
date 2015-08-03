//
//  CFRecipeSwitch.swift
//  Ctrl+Flow
//
//  Created by Rachael Gordon on 8/1/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class CFRecipeSwitch: UISwitch
{
    var thisRecipe : Recipe
    
    init(rec :Recipe)
    {
        thisRecipe = rec
        super.init(frame: CGRectZero)
    }
    
    required init(coder aDecoder: NSCoder) {
        thisRecipe = Recipe(name: "dummy", actions: [Executable](), continuous: false)
        super.init(coder: aDecoder)
    }
}
