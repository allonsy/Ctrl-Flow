//
//  CFGlobal.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/3/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class CFGlobal
{
    static let conditions : [ConditionWrapper] = [Conditions.afterTime, Conditions.beforeTime,
        Conditions.falseCondition, Conditions.trueCondition, Conditions.number, Conditions.inCall]
    static let actions : [ActionWrapper] = [Actions.flashOn, Actions.flashOff, Actions.call, Actions.notification]
    static let controls : [ControlFlowWrapper] = [ControlFlows.ifelse, ControlFlows.loopUntil, ControlFlows.loopWhile]
    static let logger = CFLogging()
}
