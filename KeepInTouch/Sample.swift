//
//  Sample.swift
//  KeepInTouch
//
//  Created by ikorobov on 21.02.2023.
//

import Foundation
import CoreData

struct Sample {

        let firstNames = ["Alice", "Bob", "Charlie", "Diana", "Ella", "Frank", "Grace", "Henry", "Isabel", "Jack"]
        let lastNames = ["Smith", "Johnson", "Brown", "Davis", "Miller", "Wilson", "Moore", "Anderson", "Taylor", "Thomas"]
        let groupNames = ["Work", "Family", "Friends"]
    
    
    
//    static func mockEvent() -> Event {
//        
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.viewContext
//        
//        let event = Event(context: viewContext)
//        event.id = UUID()
//        event.title = "Birthday"
//        event.date = Date().randomDate()
//        
//        let person = Person(context: viewContext)
//        person.id = UUID()
//        person.birthday = Date().randomDate()
//        person.firstName = "Birthday"
//        person.lastName = "Guy"
//        
//        
//        do {
//            try viewContext.save()
//        } catch {
//            print("Error saving mockEvent: \(error)")
//        }
//        
//        person.addToEvent(event)
//        
//        try? viewContext.save()
//        return event
//    }

}

//struct Sample {
//    static let groups: [Groups] = {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//
//        let dob1 = dateFormatter.date(from: "1995-02-12")!
//        let dob2 = dateFormatter.date(from: "1988-08-28")!
//        let dob3 = dateFormatter.date(from: "1990-11-01")!
//        let dob4 = dateFormatter.date(from: "1985-05-15")!
//
//        let (meeting1, meeting2, event1, event2) = {
//            let meeting1 = Meeting
//            let meeting2 = Meeting
//            let event1 = Event
//            let event2 = Event
//            return (meeting1, meeting2, event1, event2)
//        }()
//
//        let peopleWithMeeting = [
//            Person(id: UUID(), firstName: "Alice", lastName: "Jones", dateOfBirth: dob1, meetings: [meeting1], events: [event1]),
//            Person(id: UUID(), firstName: "Bob", lastName: "Smith", dateOfBirth: dob2, meetings: [meeting1], events: [event2]),
//            Person(id: UUID(), firstName: "Charlie", lastName: "Brown", dateOfBirth: dob3, meetings: [meeting1], events: []),
//            Person(id: UUID(), firstName: "Diana", lastName: "Lee", dateOfBirth: dob4, meetings: [meeting1], events: [event1, event2])
//        ]
//
//        let peopleWithEvent = [
//            Person(id: UUID(), firstName: "Alice", lastName: "Jones", dateOfBirth: dob1, meetings: [meeting1], events: [event1]),
//            Person(id: UUID(), firstName: "Bob", lastName: "Smith", dateOfBirth: dob2, meetings: [meeting2], events: [event2]),
//            Person(id: UUID(), firstName: "Charlie", lastName: "Brown", dateOfBirth: dob3, meetings: [], events: [])
//        ]
//
//        let group1 = Groups(id: UUID(), title: "Family", persons: peopleWithEvent, theme: .bubblegum)
//        let group2 = Groups(id: UUID(), title: "Friends", persons: peopleWithMeeting, theme: .buttercup)
//        let group3 = Groups(id: UUID(), title: "Work", persons: peopleWithMeeting, theme: .orange)
//
//        return [group1, group2, group3]
//    }()
//}
