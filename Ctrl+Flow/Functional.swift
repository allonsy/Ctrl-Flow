//
//  Functional.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/29/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation

func map <A,B>(f : (A) -> (B), xs : [A]) -> [B]
{
    var ret = [B]()
    for x in xs
    {
        ret.append(f(x))
    }
    return ret
}

func map_ <A>(f : (A) -> (), xs : [A]) -> ()
{
    for x in xs
    {
        f(x)
    }
}

func filter <A>(pred : (A) -> Bool, xs : [A]) -> [A]
{
    var ret = [A]()
    for x in xs
    {
        if(pred(x))
        {
            ret.append(x)
        }
    }
    return ret
}
