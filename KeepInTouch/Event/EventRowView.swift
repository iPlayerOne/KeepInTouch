//
//  EventRowView.swift
//  KeepInTouch
//
//  Created by ikorobov on 28.09.2023.
//

import SwiftUI

struct EventRowView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(event.personsArray) { person in
                Text(person.fullName)
                
            }
            HStack {
                Text(event.category)
                Spacer()
                Text(event.date.formatted())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.viewContext
    
    let event = Event(context: viewContext)
    event.id = UUID()
    event.category = "Birthday"
    event.date = Date().randomDate()
    
    let person = Person(context: viewContext)
    person.id = UUID()
    person.birthday = Date().randomDate()
    person.firstName = "Birthday"
    person.lastName = "Guy"
    
    
    do {
        try viewContext.save()
    } catch {
        print("Error saving mockEvent: \(error)")
    }
    
    event.addToPersons(person)
    try? viewContext.save()
    
    return EventRowView(event: event)
        .environment(\.managedObjectContext,viewContext)
}
