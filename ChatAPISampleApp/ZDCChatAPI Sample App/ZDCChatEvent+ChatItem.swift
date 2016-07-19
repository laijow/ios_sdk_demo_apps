/*
 *
 *  ZopimMessageFactory.swift
 *  ZDCChatAPI Sample App
 *
 *  Created by Zendesk on 6/14/16.
 *
 *  Copyright (c) 2016 Zendesk. All rights reserved.
 *
 *  By downloading or using the Zopim Chat SDK, You agree to the Zendesk Terms
 *  of Service https://www.zendesk.com/company/terms and Application Developer and API License
 *  Agreement https://www.zendesk.com/company/application-developer-and-api-license-agreement and
 *  acknowledge that such terms govern Your use of and access to the Chat SDK.
 *
 */

import ZDCChatAPI

/**
 Converts ZDCChatEvent to ChatItem for use by the UI
 */
extension ZDCChatEvent {
  
  var chatItem: ChatUIEvent {
    let date = NSDate.init(timeIntervalSince1970: self.timestamp.doubleValue / 1000.0)
    let url = self.attachment?.url == nil ? nil : NSURL(string: self.attachment.url)
    let image = self.fileUpload?.image
    
    switch self.type {
    case .AgentMessage:
      return ChatAgentMessageEvent(id: self.eventId,
                                   confirmed: self.verified,
                                   timeStamp: date,
                                   text: self.message,
                                   avatarURL: nil)
    case .VisitorMessage:
      return ChatVisitorMessageEvent(id: self.eventId,
                                     confirmed: self.verified,
                                     timeStamp: date,
                                     text: self.message)
    case .VisitorUpload:
      let confirmed = self.fileUpload.status == .Complete
      return ChatVisitorImageEvent(id: self.eventId,
                                   confirmed: confirmed,
                                   timeStamp: date,
                                   image: image,
                                   imageURL: url)
    case .AgentUpload:
      return ChatAgentImageEvent(id: self.eventId,
                                 confirmed: true,
                                 timeStamp: date,
                                 image: image,
                                 imageURL: url,
                                 avatarURL: nil)
      
    default:
      assert(false, "Type not supported")
    }
  }
}