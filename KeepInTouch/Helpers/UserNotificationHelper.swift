//
//  NotificationHelper.swift
//  KeepInTouch
//
//  Created by ikorobov on 15.10.2023.
//

import UserNotifications

enum NotificationFrequency: String, CaseIterable {
    case onceADay = "2young2die"
    case threeTimesADay = "Hurt me"
    case everyFewHours = "Nightmare"
}

struct UserNotificationHelper {
    
    private var notificationController = NotificationController.shared
    
    
    func clearAllNotification() {
        
    }
    
    func schelduleNotification(for frenquency: NotificationFrequency, forEvent event: Event ) {
        
        let title = "Good news!"
        let body = "It's \(event.personsArray.first?.fullName ?? "Someone's")'s \(event.category) "
        
        guard let identifier = event.notificationID else { return }
        
        switch frenquency {
            case .threeTimesADay:
                let time: [DateComponents] = [
                    DateComponents(hour: 9),
                    DateComponents(hour:13),
                    DateComponents(hour: 19)
                ]
                for time in time {
                    notificationController.schelduleNotification(identifier: identifier , title: title, body: body, dateComponents: time)
                }
            case .everyFewHours:
                for hour in stride(from: 9, through: 23, by: 3) {
                    let time = DateComponents(hour: hour)
                    notificationController.schelduleNotification(identifier: identifier, title: title, body: body, dateComponents: time)
                }
            default:
                let daily = DateComponents(hour: 12)
                notificationController.schelduleNotification(identifier: identifier, title: title, body: body, dateComponents: daily)
        }
    }
}
