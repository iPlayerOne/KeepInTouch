//
//  Event.swift
//  KeepInTouch
//
//  Created by ikorobov on 28.09.2023.
//

import Foundation

extension Event {
    
    var title: String {
        get { title_ ?? "No title" }
        set { title_ = newValue }
    }
    
    var date: Date {
        get { date_ ?? Date() }
        set { date_ = newValue }
    }
    
    var category: String {
        get { category_ ?? "No category" }
        set { category_ = newValue }
    }
    
    var note: String {
        get { note_ ?? ""}
        set { note_ = newValue }
    }
    
    var personsArray: [Person] {
        let set = persons as? Set<Person> ?? []
        return Array(set)
    }
}
