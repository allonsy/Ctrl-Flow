//
//  RecvGmailCondition.swift
//  Ctrl+Flow
//
//  Created by Alec Snyder on 8/12/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

import UIKit

class RecvGmailCondition : Condition
{
    var emails : [GTLGmailMessage] = [GTLGmailMessage]()
    private func getNewMessage(service : GTLServiceGmail) -> GTLGmailMessage?
    {
        let newList = getEmailList(service)
        if(emails == [])
        {
            emails = newList
            return nil
        }
        if(emails == newList)
        {
            return nil
        }
        let messageQuery = GTLQueryGmail.queryForUsersMessagesGet()
        messageQuery.identifier = newList[0].identifier
        let tick = service.executeQuery(messageQuery, completionHandler: displayResultWithTicket)
        while(!tick.hasCalledCallback)
        {
        }
        emails = newList
        return (tick.fetchedObject as! GTLGmailMessage)
    }
    private func returnSender(service : GTLServiceGmail) -> String
    {
        var message = getNewMessage(service)
        while(message == nil)
        {
            message = getNewMessage(service)
        }
        for header in message!.payload.headers
        {
            let realHeader = header as! GTLGmailMessagePartHeader
            if(realHeader.name == "From")
            {
                return realHeader.value
            }
        }
        //print("contents: \(message!.payload.parts)")
        return "sender"
    }
    
    func allTogetherNow(_ : Any?) -> Any?
    {
        if(arg == nil)
        {
            CFGlobal.logger.notificationLog("No Credentials")
            return nil
        }
        let retArg = arg! as! GTLServiceGmail
        let sender = returnSender(retArg)
        return sender
    }
}
private func getEmailList(service : GTLServiceGmail) -> [GTLGmailMessage]
{
    let query = GTLQueryGmail.queryForUsersMessagesList()
    let tick = service.executeQuery(query, completionHandler: displayResultWithTicket)
    while(!tick.hasCalledCallback)
    {
    }
    let messages = tick.fetchedObject as! GTLGmailListMessagesResponse
    return messages.messages as! [GTLGmailMessage]
}

private func displayResultWithTicket(ticket: GTLServiceTicket?, response: AnyObject?, error : NSError?)
{
    if(error != nil)
    {
        CFGlobal.logger.notificationLog("Error in request")
    }
}

private func returnGoogleEmailCondition() -> Condition
{
    let retCond = RecvGmailCondition()
    retCond.name = "Receive a gmail"
    retCond.argumentPickerVC = GoogleAuth()
    retCond.executeBlock = retCond.allTogetherNow
    return retCond
}

let receiveGmailCondititon = ConditionWrapper(name: "Receive Gmail", description: "When a gmail is received", returnConditionFunc: returnGoogleEmailCondition)
