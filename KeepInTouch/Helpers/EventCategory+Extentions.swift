//
//  EventCategory+Extentions.swift
//  KeepInTouch
//
//  Created by ikorobov on 13.10.2023.
//

import Foundation

extension EventCategory {
    
    func categoryIconName(for category: EventCategory) -> String {
        if let iconName = category.iconName {
            return iconName
        }
        switch category.title {
            case "Birthday":
                return "birthday.cake"
            case "Anniversary":
                return "calendar"
            case "Wedding day":
                return "heart.rectangle"
            case "Child's Birthday":
                return "balloon.2"
            default:
                return "plus"
        }
    }
}
