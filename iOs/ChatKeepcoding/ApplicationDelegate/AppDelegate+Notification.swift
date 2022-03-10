//
//  AppDelegate+Notification.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 10/3/22.
//  Copyright © 2022 ERISCO. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit
import FirebaseMessaging

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func registerForPushNotifications(_ application: UIApplication){
        
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
        }else{
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().subscribe(toTopic: "GENERAL")
    }
    
}

