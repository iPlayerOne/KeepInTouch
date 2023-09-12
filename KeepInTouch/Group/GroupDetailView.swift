//
//  GroupDetailView.swift
//  KeepInTouch
//
//  Created by ikorobov on 04.08.2023.
//

import SwiftUI

struct GroupDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var updateOperation: UpdateOperation<Groups>?
    
    @ObservedObject var group: Groups
    
    var body: some View {
        Form {
            Section {
                Text(group.title)
                    .foregroundColor(group.colorTheme.accentColor)
            }
            .listRowBackground(group.colorTheme.mainColor)
            
            Section(header: Text("Members")) {
                List {
                    ForEach(group.personsArray) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            Text(person.fullName)
                        }
                    }
                }
            }
        }
        .navigationTitle(group.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing ) {
                Button {
                    updateOperation = UpdateOperation(withExisting: group, in: viewContext)
                } label: {
                    Text("Edit")
                }

//                Button("Edit") {
//                    updateOperation = UpdateOperation(withExisting: group, in: viewContext)
//                }
            }
        }
        .sheet(item: $updateOperation) { updateOperation in
            NavigationView {
                GroupEditView(group: updateOperation.childObject, isEdit: true)
            }
            .environment(\.managedObjectContext, updateOperation.childContext)
        }
    }
    
    struct GroupDetailView_Previews: PreviewProvider {
        static var previews: some View {
            let result = PersistenceController(inMemory: true)
            let viewContext = result.viewContext
            
            let person1 = Person(context: viewContext)
            person1.firstName = "John"
            person1.lastName = "Doe"
            
            let person2 = Person(context: viewContext)
            person2.firstName = "Jane"
            person2.lastName = "Smith"
            
            
            let newGroup = Groups(context: viewContext)
            newGroup.id = UUID()
            newGroup.title = "Friends Group"
            newGroup.colorTheme = ColorTheme.bubblegum
            newGroup.addToPersons(NSSet(array: [person1, person2]))
            
            return GroupDetailView(group: newGroup)
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
