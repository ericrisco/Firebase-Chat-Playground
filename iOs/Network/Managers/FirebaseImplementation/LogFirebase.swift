//
//  LogFirebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 10/3/22.
//  Copyright © 2022 ERISCO. All rights reserved.
//

import Foundation
import Firebase

public class LogFirebase: LogManager {
    
    public func log(event: Event) {
        Analytics.logEvent(event.name, parameters: event.parameters as? [String: Any])
    }
    
}
