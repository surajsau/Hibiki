//
//  Event.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 05/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import Foundation
import Swifter

class Event {
    let created_ts: String?
    let type: String?
    let messageCreate: MessageCreate?
    let id: String?
    
    init(created_ts: String?,
         type: String?,
         messageCreate: JSON?,
         id: String?) {
        self.created_ts = created_ts
        self.type = type
        self.messageCreate = messageCreate?.messageCreate()
        self.id = id
    }
    
}

class MessageCreate {
    let target: Target?
    let messageData: MessageData?
    let sourceAppId: String?
    let senderId: String?
    
    init(target: JSON?,
         messageData: JSON?,
         sourceAppId: String?,
         senderId: String?) {
        self.target = messageData?.target()
        self.messageData = messageData?.messageData()
        self.sourceAppId = sourceAppId
        self.senderId = senderId
    }
}

class MessageData {
    
    let text: String?
    
    init(text: String?,
         entities: JSON?) {
        self.text = text
    }
}

class Target {
    
    let recipientId: String?
    
    init(recipientId: String?) {
        self.recipientId = recipientId
    }
}

extension JSON {
    
    func event() -> Event {
        return Event(created_ts: self["created_timestamp"].string,
                       type: self["type"].string,
                       messageCreate: self["message_create"],
                       id: self["id"].string)
    }
    
    func messageCreate() -> MessageCreate {
        return MessageCreate(target: self["target"],
                             messageData: self["message_data"],
                             sourceAppId: self["source_app_id"].string,
                             senderId: self["sender_id"].string)
    }
    
    func messageData() -> MessageData {
        return MessageData(text: self["text"].string,
                           entities: self["entities"])
    }
    
    func target() -> Target {
        return Target(recipientId: self["recipient_id"].string)
    }
    
}
