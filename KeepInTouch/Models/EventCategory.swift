//
//  Category.swift
//  KeepInTouch
//
//  Created by ikorobov on 09.10.2023.
//

import Foundation

struct EventCategory: Codable, Identifiable {
    var id = UUID().uuidString
    var title: String
    var iconName: String?
}

extension EventCategory {
    static let example = EventCategory(title: "Birthday")
}
