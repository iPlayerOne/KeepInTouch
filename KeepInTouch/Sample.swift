//
//  Sample.swift
//  KeepInTouch
//
//  Created by ikorobov on 21.02.2023.
//



import Foundation

struct Sample {
    static let sampleData: [Group] = {
 

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dob1 = dateFormatter.date(from: "1995-02-12")!
        let dob2 = dateFormatter.date(from: "1988-08-28")!
        let dob3 = dateFormatter.date(from: "1990-11-01")!
        let dob4 = dateFormatter.date(from: "1985-05-15")!

        let (meeting1, meeting2, event1, event2) = {
            let meeting1 = Meeting(id: UUID(), date: Date())
            let meeting2 = Meeting(id: UUID(), date: Date())
            let event1 = Event(id: UUID(), title: "Birthday Party", date: Date())
            let event2 = Event(id: UUID(), title: "Concert", date: Date())
            return (meeting1, meeting2, event1, event2)
        }()

        let peopleWithMeeting = [            Person(id: UUID(), firstName: "Alice", lastName: "Jones", birthday: dob1, meetings: [meeting1], events: [event1]),
            Person(id: UUID(), firstName: "Bob", lastName: "Smith", birthday: dob2, meetings: [meeting1], events: [event2]),
            Person(id: UUID(), firstName: "Charlie", lastName: "Brown", birthday: dob3, meetings: [meeting1], events: []),
            Person(id: UUID(), firstName: "Diana", lastName: "Lee", birthday: dob4, meetings: [meeting1], events: [event1, event2])
        ]

        let peopleWithEvent = [            Person(id: UUID(), firstName: "Alice", lastName: "Jones", birthday: dob1, meetings: [meeting1], events: [event1]),
            Person(id: UUID(), firstName: "Bob", lastName: "Smith", birthday: dob2, meetings: [meeting2], events: [event2]),
            Person(id: UUID(), firstName: "Charlie", lastName: "Brown", birthday: dob3,  meetings: [], events: [])
        ]
        let group1 = Group(id: UUID(), title: "Family", persons: peopleWithEvent , colorTheme: ColorTheme.bubblegum)
        let group2 = Group(id: UUID(), title: "Friends", persons: peopleWithMeeting, colorTheme: ColorTheme.buttercup)
        let group3 = Group(id: UUID(), title: "Work", persons: peopleWithMeeting, colorTheme: ColorTheme.orange)

        return [ group1, group2, group3 ]
    }()
}

//import Foundation
//
//struct Sample {
//
//    let sampleData: [Person] = []
//    let group1 = Group(id: UUID(), title: "Family", colorTheme: ColorTheme.bubblegum)
//    let group2 = Group(id: UUID(), title: "Friends", colorTheme: ColorTheme.buttercup)
//    let group3 = Group(id: UUID(), title: "Work", colorTheme: ColorTheme.orange)
//
//    let dateFormatter = DateFormatter()
//
//    // Initialize meetings and events in a separate method
//    func initializeMeetingsAndEvents() -> (Meeting, Meeting, Event, Event) {
//        let meeting1 = Meeting(id: UUID(), date: Date())
//        let meeting2 = Meeting(id: UUID(), date: Date())
//        let event1 = Event(id: UUID(), title: "Birthday Party", date: Date())
//        let event2 = Event(id: UUID(), title: "Concert", date: Date())
//        return (meeting1, meeting2, event1, event2)
//    }
//
//    // Initialize people with meetings and events
//    let dob1 = dateFormatter.date(from: "1995-02-12")
//    let dob2 = dateFormatter.date(from: "1988-08-28")
//    let dob3 = dateFormatter.date(from: "1990-11-01")
//    let dob4 = dateFormatter.date(from: "1985-05-15")
//    let (meeting1, meeting2, event1, event2) = initializeMeetingsAndEvents()
//    let peopleWithMeeting = [        Person(id: UUID(), firstName: "Alice", lastName: "Jones", dateOfBirth: dob1!, group: [group1], meetings: [meeting1], events: [event1]),
//                                     Person(id: UUID(), firstName: "Bob", lastName: "Smith", dateOfBirth: dob2!, group: [group1], meetings: [meeting1], events: [event2]),
//                                     Person(id: UUID(), firstName: "Charlie", lastName: "Brown", dateOfBirth: dob3!, group: [group1], meetings: [meeting1], events: []),
//                                     Person(id: UUID(), firstName: "Diana", lastName: "Lee", dateOfBirth: dob4!, group: [group1], meetings: [meeting1], events: [event1, event2])
//    ]
//
//    // Initialize people with events
//    let peopleWithEvent = [
//        Person(id: UUID(), firstName: "Alice", lastName: "Jones", birthday: dob1!, meetings: [meeting1], events: [event1], group: [group1]),
//        Person(id: UUID(), firstName: "Bob", lastName: "Smith", birthday: dob2!, meetings: [meeting2], events: [event2], group: [group2]),
//        Person(id: UUID(), firstName: "Charlie", lastName: "Brown", birthday: dob3!, meetings: [], events: [], group:[group3])
//    ]
//}

//    let sampleData: [Person] = []
//    let group1 = Group(id: UUID(), title: "Family", colorTheme: ColorTheme.bubblegum)
//    let group2 = Group(id: UUID(), title: "Friends", colorTheme: ColorTheme.buttercup)
//    let group3 = Group(id: UUID(), title: "Work", colorTheme: ColorTheme.orange)
//
//
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd"
//
//    // Create some meetings and events to use in the person instances
//    let meeting1 = Meeting(id: UUID(), date: Date())
//    let meeting2 = Meeting(id: UUID(), date: Date())
//    let event1 = Event(id: UUID(), title: "Birthday Party", date: Date())
//    let event2 = Event(id: UUID(), title: "Concert", date: Date())
//
//    // Array of people with the same meeting
//    let dob1 = dateFormatter.date(from: "1995-02-12")
//    let dob2 = dateFormatter.date(from: "1988-08-28")
//    let dob3 = dateFormatter.date(from: "1990-11-01")
//    let dob4 = dateFormatter.date(from: "1985-05-15")
//    let peopleWithMeeting = [
//        Person(id: UUID(), firstName: "Alice", lastName: "Jones", dateOfBirth: dob1!, group: [group1], meetings: [meeting1], events: [event1]),
//        Person(id: UUID(), firstName: "Bob", lastName: "Smith", dateOfBirth: dob2!, group: [group1], meetings: [meeting1], events: [event2]),
//        Person(id: UUID(), firstName: "Charlie", lastName: "Brown", dateOfBirth: dob3!, group: [group1], meetings: [meeting1], events: []),
//        Person(id: UUID(), firstName: "Diana", lastName: "Lee", dateOfBirth: dob4!, group: [group1], meetings: [meeting1], events: [event1, event2])
//    ]
//
//    // Array of people with the same event
//    let peopleWithEvent = [
//        Person(id: UUID(), firstName: "Alice", lastName: "Jones", dateOfBirth: dob1!, group: [group2], meetings: [meeting1], events: [event1]),
//        Person(id: UUID(), firstName: "Bob", lastName: "Smith", dateOfBirth: dob2!, group: [group2], meetings: [meeting2], events: [event1]),
//        Person(id: UUID(), firstName: "Charlie", lastName: "Brown", dateOfBirth: dob3!, group: [group2], meetings: [], events: [event1]),
//        Person(id: UUID(), firstName: "Diana", lastName: "Lee", dateOfBirth: dob4!, group: [group2], meetings: [], events: [event1])
//    ]
//
//    // Array of people with similar ages
//    let dob5 = dateFormatter.date(from: "1992-03-25")
//    let dob6 = dateFormatter.date(from: "1992-06-12")
//    let dob7 = dateFormatter.date(from: "1993-01-10")
//    let dob8 = dateFormatter.date(from: "1993-05-20")
//    let peopleWithSimilarAges = [
//        Person(id: UUID(), firstName: "Alice", lastName: "Jones", dateOfBirth: dob5!, group: [group3], meetings: [meeting1], events: [event1]),
//        Person(id: UUID(), firstName: "Bob", lastName: "Smith", dateOfBirth: dob6!,group: [group3], meetings: [meeting2], events: [event2]),
//        Person(id: UUID(), firstName: "Charlie", lastName: "Brown", dateOfBirth: dob7!,group: [group3], meetings: [], events: [event1]),
//        Person(id: UUID(), firstName: "Diana", lastName: "Lee", dateOfBirth: dob8!, group: [group3], meetings: [], events: [event2])
//    ]
//}
