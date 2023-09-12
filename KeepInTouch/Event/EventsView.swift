//
//  MainEventView.swift
//  KeepInTouch
//
//  Created by ikorobov on 28.09.2023.
//

import SwiftUI

struct EventsView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Event.entity(), sortDescriptors:[NSSortDescriptor(key: "date_", ascending: true)]) private var events: FetchedResults<Event>
    
    private var todaysEvents: [Event] {
        events.filter { $0.date.isToday() }
    }
    
    private var thisMonthEvents: [Event] {
        events.filter { !$0.date.isToday() && $0.date.isThisMonth() }
    }
    
    var body: some View {
        ZStack {
            List {
                if !todaysEvents.isEmpty {
                    Section(header: Text("Today")) {
                        ForEach(todaysEvents) { event in
                            EventRowView(event: event)
                        }
                    }
                } else { Text("Something goes wrong")}
                if !thisMonthEvents.isEmpty {
                    Section(header: Text("This Month")) {
                        ForEach(thisMonthEvents) { event in
                            EventRowView(event: event)
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            VStack {
                Spacer()
                HStack {
                    ButtonView(action: deleteAllEvents, imageString: "minus.square.fill", color: .red)
                        .padding()
                    Spacer()
                    ButtonView(action: PersistenceController.shared.createMockEvent, imageString: "plus.app.fill", color: .gray)
                        .padding()
                    ButtonView(action: {}, imageString: "plus.circle.fill", color: .blue)
                    .padding()
                }
            }
        }
    }
    
    private func deleteAllEvents() {
        for event in events {
            viewContext.delete(event)
        }
        viewContext.saveContext()
    }
}

#Preview {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.viewContext
    let sample = Sample()
    
    for i in 0..<2 {
        let newEvent = Event(context: viewContext)
        newEvent.id = UUID()
        newEvent.title = "Event\(i)"
        newEvent.date = Date()
        
        let person = Person(context: viewContext)
        person.id = UUID()
        person.birthday = Date().randomDate()
        person.firstName = sample.firstNames.randomElement() ?? "no name"
        person.lastName = sample.lastNames.randomElement() ?? "no surname"
        
        person.addToEvent(newEvent)
    }
    
    try? viewContext.save()
    
    for i in 0..<2 {
        let newEvent = Event(context: viewContext)
        newEvent.id = UUID()
        newEvent.title = "Event_\(i)"
        newEvent.date = Date().randomDate()
        
        let person = Person(context: viewContext)
        person.id = UUID()
        person.birthday = Date().randomDate()
        person.firstName = sample.firstNames.randomElement() ?? "no name"
        person.lastName = sample.lastNames.randomElement() ?? "no surname"
        
        person.addToEvent(newEvent)
    }
    
    try? viewContext.save()
    
    return EventsView()
        .environment(\.managedObjectContext, viewContext)
        
}
