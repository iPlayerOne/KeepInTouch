//
//  EventAddEditView.swift
//  KeepInTouch
//
//  Created by ikorobov on 13.10.2023.
//

import SwiftUI

struct EventAddEditView: View {
    @Environment(\.managedObjectContext) private var childContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var event: Event
    
    @State private var newCategory = ""
    @State private var newDate = Date()
    @State private var note = ""
    @State private var showCustomCategoryTF = false
    
    
    
    @State var isEdit: Bool
    
    
    var body: some View {
        Form {
            Section(header: Text("Event Information")) {
                EventCategoryMenuView(showCustomCategoryTF: $showCustomCategoryTF)
                
                if showCustomCategoryTF {
                    TextField("Enter your category", text: $newCategory)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                DatePicker("Date", selection: $newDate, displayedComponents: .date)
            }
            Section(header: Text("Related Contacts")) {
                List {
                    ForEach(event.personsArray) { person in
                        PersonCellView(person: person, isSelected: false, toggleSelection: {_ in}, viewMode: .navigation)
//                        Text(person.fullName)
                        
                    }
                }
            }
            Spacer()
                TextEditor(text: $note)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
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
    
    for i in 0..<2 {
        let newEvent = Event(context: viewContext)
        newEvent.id = UUID()
        newEvent.category = "Event_\(i)"
        newEvent.date = Date().randomDate()
        
        let person = Person(context: viewContext)
        person.id = UUID()
        person.birthday = Date().randomDate()
        person.firstName = sample.firstNames.randomElement() ?? "no name"
        person.lastName = sample.lastNames.randomElement() ?? "no surname"
        
        person.addToEvents(newEvent)
    }
    
    try? viewContext.save()
    
    return EventAddEditView(event: newEvent, isEdit: true)
        .environment(\.managedObjectContext, viewContext)
}
