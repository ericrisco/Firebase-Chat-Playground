//
//  DiscussionFirebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 7/3/22.
//  Copyright © 2022 ERISCO. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class DiscussionFirebase: DiscussionManager {
    
    public func list(onSuccess: @escaping ([Discussion]) -> Void, onError: ErrorClosure?) {
        
        let ref = Database.database().reference().child("discussions")
        ref.observe(.value) { snapshot in
            
            let discussions = snapshot
                .children
                .compactMap({ Discussion.mapper(snapshot: $0 as! DataSnapshot) })
            
            onSuccess(discussions)
            
        }
        
        
        
    }
    
}
