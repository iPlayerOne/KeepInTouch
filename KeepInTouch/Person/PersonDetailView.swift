
//  PersonDetailView.swift
//  KeepInTouch
//
//  Created by ikorobov on 24.02.2023.


import SwiftUI

struct PersonDetailView: View {
    @ObservedObject var person: Person
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10){
                Text(person.fullName)
                    .font(.largeTitle)
                    .padding(.trailing, 15)
                Spacer()
                GreetButtonView(isActive: false)
                    .padding()
                ContactStackView(width: 40, height: 40)
                Spacer()
                List {
                    Section(header: Text("Events")) {
                        ForEach(person.eventsArray) { event in
                            EventRowView(event: event)
                        }
                    }
                }

            }
        }
        .padding()
        .navigationTitle("person detail")
        .toolbar {
            Button(action: {
                isEditing = true
            }) {
                Image(systemName: "pencil")
            }
        }
        .sheet(isPresented: $isEditing) {
            PersonAddEditView(person: person, isEdit: true)
        }
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        let viewContext = persistenceController.container.viewContext
        let person = Person(context: viewContext)
        
        person.firstName = "Kot"
        person.lastName = "Kotovich"
        person.birthday = Date()
        
        return PersonDetailView(person: person)
            .environment(\.managedObjectContext, viewContext)
    }
}
