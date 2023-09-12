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
    
    var personsArray: [Person] {
        let set = persons as? Set<Person> ?? []
        return Array(set)
    }
}
