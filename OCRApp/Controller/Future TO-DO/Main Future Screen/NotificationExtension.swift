//
//  NotificationExtension.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import UserNotifications

//MARK: - UNUserNotificationCenterDelegate
extension FunctionsViewController : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
}

//MARK: - Local Notification
extension FunctionsViewController {
    func notification() {
        
        let noticationCenter = UNUserNotificationCenter.current()
        noticationCenter.delegate = self
        
        noticationCenter.requestAuthorization(options: [.alert,.sound,.badge]) { (granted, error) in
            guard granted else { return }
            noticationCenter.getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "First notification"
        content.body = "My first notification"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        noticationCenter.add(request) { (error) in
            print(error?.localizedDescription)
        }
    }
    
}
