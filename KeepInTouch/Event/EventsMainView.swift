//
//  EventsMainView.swift
//  KeepInTouch
//
//  Created by ikorobov on 01.10.2023.
//

import SwiftUI

struct EventsMainView: View {
    var body: some View {
        ZStack {
            EventsView()
        }
    }
}

#Preview {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.viewContext
    let sample = Sample()
    
    for _ in 0..<2 {
        let newEvent = Event(context: viewContext)
        newEvent.id = UUID()
        newEvent.category = "Event"
        newEvent.date = Date()
        
        let person = Person(context: viewContext)
        person.id = UUID()
        person.birthday = Date().randomDate()
        person.firstName = sample.firstNames.randomElement() ?? "no name"
        person.lastName = sample.lastNames.randomElement() ?? "no surname"
        
        person.addToEvents(newEvent)
        
        try? viewContext.save()
    }
    
    for i in 0..<2 {
        let newEvent = Event(context: viewContext)
        newEvent.id = UUID()
        newEvent.category = "Event_\(i)"
        newEvent.date = Date().randomDateUntilMonthEnds()
        
        let person = Person(context: viewContext)
        person.id = UUID()
        person.birthday = Date().randomDate()
        person.firstName = sample.firstNames.randomElement() ?? "no name"
        person.lastName = sample.lastNames.randomElement() ?? "no surname"
        
        person.addToEvents(newEvent)
        
        try? viewContext.save()
    }
    
    return EventsMainView()
        .environment(\.managedObjectContext, viewContext)
}
