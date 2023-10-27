//
//  EventDetailView.swift
//  KeepInTouch
//
//  Created by ikorobov on 14.10.2023.
//

import SwiftUI

struct EventDetailView: View {
    @ObservedObject var event: Event
    
    var body: some View {
        VStack {
            Text(event.category)
                .font(.largeTitle)
                .padding(.trailing, 15)
            Spacer()
            Section(header: Text("Related Contacts")) {
                List {
                    ForEach(event.personsArray) { person in
                        PersonCellView(person: person, isSelected: false, toggleSelection: {_ in}, viewMode: .navigation)
                        
                    }
                }
                NotificationSegmentPickerView()
                Button("Remove Notification") {
                    if let notificationID = event.notificationID {
                        NotificationController.shared.clearSpecificNotification(identifier: notificationID)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.viewContext
    let sample = Sample()
    
    let newEvent = Event(context: viewContext)
    newEvent.id = UUID()
    newEvent.category = "Birthday"
    newEvent.date = Date()
    
    let person = Person(context: viewContext)
    person.id = UUID()
    person.birthday = Date().randomDate()
    person.firstName = sample.firstNames.randomElement() ?? "no name"
    person.lastName = sample.lastNames.randomElement() ?? "no surname"
    
    person.addToEvents(newEvent)
    
    try? viewContext.save()
    return EventDetailView(event: newEvent)
        .environment(\.managedObjectContext, viewContext)
}
