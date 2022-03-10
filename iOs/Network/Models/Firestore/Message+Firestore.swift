//
//  MessageFirestore.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 8/3/22.
//  Copyright © 2022 ERISCO. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MessageKit

extension Message {
    
    public class func mapperFirestore(json: QueryDocumentSnapshot) -> Message? {
        
        let senderId = json["senderId"] as? String ?? ""
        let displayName = json["displayName"] as? String ?? ""
        let sender = Sender.init(senderId: senderId, displayName: displayName)
        
        let messageId = json["messageId"] as? String ?? ""
        
        let dateString = json["sentDate"] as? String ?? ""
        let sentDate = Date.fromStringToDate(input: dateString, format: "yyyy-MM-dd HH:mm:ss")
        
        let value = json["value"] as? String ?? ""
        let type = json["type"] as? String ?? ""

        let kind: MessageKind
        
        switch type {
        case "text":
            kind = MessageKind.text(value)
        case "image":
            let placeholder = UIImage.init(named: "diehard")
            let mediaItem = ImageMediaItem.init(image: placeholder!)
            kind = MessageKind.photo(mediaItem)
        default:
            kind = MessageKind.text(value)
        }
        
        let message = Message.init(sender: sender,
                                   messageId: messageId,
                                   sentDate: sentDate,
                                   kind: kind,
                                   type: type,
                                   value: value)
        
        return message
        
    }
    
}
