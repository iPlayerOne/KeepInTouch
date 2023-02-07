//
//  Person.swift
//  KeepInTouch
//
//  Created by ikorobov on 20.02.2023.
//

import Foundation

struct Person: Identifiable, Decodable {
    let id: UUID
    var firstName: String
    var lastName: String
    var birthday: Date
    var meetings: [Meeting]
    var events: [Event]
    
    var fullName: String {
        firstName + lastName
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()
    
    init(id: UUID, firstName: String, lastName: String, birthday: Date, meetings: [Meeting], events: [Event]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.birthday = birthday
        self.meetings = meetings
        self.events = events
    }
}

struct Group: Identifiable, Decodable {
    let id: UUID
    var title: String
    var persons: [Person]
    var colorTheme: ColorTheme
}

struct Meeting: Identifiable, Decodable {
    let id: UUID
    var date: Date
}

struct Event: Identifiable, Decodable {
    let id: UUID
    var title: String
    var date: Date
}

