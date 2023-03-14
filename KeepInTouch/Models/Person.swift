//
//  Person.swift
//  KeepInTouch
//
//  Created by ikorobov on 20.02.2023.
//

import Foundation

struct Person: Identifiable, Codable {
    let id: UUID
    var firstName: String
    var lastName: String
    var birthday: Date
    var meetings: [Meeting]
    var events: [Event]
    
    var fullName: String {
        firstName + " " + lastName
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

extension Person {
    
    struct Group: Identifiable, Codable {
        let id: UUID
        var title: String
        var persons: [Person]
        var colorTheme: ColorTheme
    }
    
    struct Meeting: Identifiable, Codable {
        let id: UUID
        var date: Date
    }
    
    struct Event: Identifiable, Codable {
        let id: UUID
        var title: String
        var date: Date
    }
    
    struct Data {
        var firstName: String = ""
        var lastName: String = ""
        var birthday: Date = Date()
        var meetings:[Meeting] = []
        var events: [Event] = []
    }
    
    var data: Data {
        Data(
            firstName: firstName,
            lastName: lastName,
            birthday: birthday,
            meetings: meetings,
            events: events
        )
    }
    
    mutating func update(from data: Data) {
        firstName = data.firstName
        lastName = data.lastName
        birthday = data.birthday
        meetings = data.meetings
        events = data.events
    }
    
    init(data: Data) {
        id = UUID()
        firstName = data.firstName
        lastName = data.lastName
        birthday = data.birthday
        meetings = data.meetings
        events = data.events
    }

}




