//
//  NotificationController.swift
//  KeepInTouch
//
//  Created by ikorobov on 27.09.2023.
//

import UserNotifications

class NotificationController {
    // singleton
    
    static let shared = NotificationController()
    
    // Notification center for manage local notification
    
    private let center = UNUserNotificationCenter.current()
    
    // Store identifier of scheduled notifications
    
    private var notificationID: [String] = []
    
    // private init for the sake of singlton
    
    private init() { }
    
    // request permission
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Request permission error: \(error.localizedDescription)")
                }
                completion(granted)
            }
        }
    }
    
    // Checking permissions
    func checkNotificationPermission(completion: @escaping (UNAuthorizationStatus) -> Void) {
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    // Notification time plannig
    
    func schelduleNotification(identifier: String, title: String, body: String, dateComponents: DateComponents) {
        // new notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        //trigger creation
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //request creation
//        let identifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationID.append(identifier)
        
        //Request adding
        center.add(request) { error in
            if let error = error {
                print("Some notification error: \(error.localizedDescription)")
            }
            
        }
    }
    //Delete specific notification
    func clearSpecificNotification(identifier: String) {
        var notificationID: [String] = []
        notificationID.append(identifier)
        center.removePendingNotificationRequests(withIdentifiers: notificationID)
    }
    //Delete all notifications
    func clearAllNotification() {
        center.removeAllPendingNotificationRequests()
        notificationID.removeAll()
    }
    
}
