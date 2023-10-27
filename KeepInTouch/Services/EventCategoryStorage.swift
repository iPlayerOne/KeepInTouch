//
//  EventCategoryStorage.swift
//  KeepInTouch
//
//  Created by ikorobov on 12.10.2023.
//

import Foundation

class EventCategoryStorage: ObservableObject {
    private let key = "eventCategories"
    @Published var categories: [EventCategory] = []
    
    init() {
        load()
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode([EventCategory].self, from: data) {
                self.categories = decoded
                return
            }
        }
        self.categories = defaultCategories()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(categories) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func addCategory(_ category: EventCategory) {
        if !categories.contains(where: {$0.title == category.title}) {
            categories.append(category)
            save()
        }
    }
    
    func defaultCategories() -> [EventCategory] {
        return [
            EventCategory(title: "Birthday"),
            EventCategory(title: "Anniversary"),
            EventCategory(title: "Wedding day"),
            EventCategory(title: "Child's Birthday")
        ]
    }
}
