
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
            Form {
                Section(header: Text("Group")) {
                    //                    Text("\(person.groups?.allObjects[0].title ?? "Ungrouped")")
                }
                
                Section(header:Text("Pesonal data")) {
                    Text("\(person.firstName)")
                    Text("\(person.lastName)")
                    Text(DateFormatterHelper.shared.format(person.birthday))
                }
            }
        }
        .padding()
        .navigationTitle("\(person.fullName)")
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
