
//
//  ActionProtocol.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 7/30/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import Foundation

protocol Executable
{
    func getName() -> String
    func execute() -> Bool
}

protocol CallbackWhenReadyDelegate : class
{
    weak var callBackDelegate : CallbackWhenReadyDelegate? { get set }
    func objIsReady() -> Any?
}

typealias ActionSequence = [Executable]