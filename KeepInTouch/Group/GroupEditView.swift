//
//  GroupEditView.swift
//  KeepInTouch
//
//  Created by ikorobov on 15.03.2023.
//

import SwiftUI

struct GroupEditView: View {
    
    @Environment(\.managedObjectContext) private var childContext
    @Environment(\.dismiss) var dismiss
    
    
    @ObservedObject var group: Groups
    
    @State private var createOperation: CreateOperation<Person>?
    @State private var newTitle: String = ""
    @State private var newColorTheme: ColorTheme = .bubblegum
    @State private var selectedPersons: [Person] = []
    
    @State var isEdit: Bool
    @State private var isPopup: Bool = false
    @State private var isAddNewPerson = false
    
    var body: some View {
        Form {
            Section(header: Text("")) {
                TextField("Title", text: isEdit ? $group.title : $newTitle)
                GroupThemePicker(selection: isEdit ? $group.colorTheme : $newColorTheme)
            }
            
            Section(header: Text("Add Member")) {
                Button {
                    isPopup = true
                    createOperation = CreateOperation(with: childContext)
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                        Text("Add Member")
                            .foregroundColor(.blue)
                    }
                }
            }
            
            Section(header: Text("Members")) {
                
                List {
                    ForEach(group.personsArray) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            Text(person.fullName)
                        }
                    }
                }
            }
            
            Section {
                HStack {
                    Spacer()
                    Button(action: {
                        isEdit ? updateGroup() : createGroup()
                        print( isEdit ? "update button" : "create button")
                    }) {
                        Text( isEdit ? "Done" : "Create")
                    }
                    .padding()
                    .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button(action: {
                        isEdit
                        ?
                        deleteGroup()
                        :
                        childContext.rollback()
                        dismiss()
                        print(print( isEdit ? "delete button" : "cancel button"))
                    }) {
                        Text(isEdit ? "Delete Group" : "Cancel")
                        
                    }
                    .foregroundColor(.red)
                    Spacer()
                }
                .buttonStyle(BorderedButtonStyle())
            }
            .navigationBarTitle(isEdit ? "Edit Group" : "Create Group")
        }
        .popupNavigationView(isPresented: $isPopup, horizontalPadding: 40, verticalPadding: 200, cornerRadius: 15) {
            TempPersonListView(viewMode: .selection, selectedPersons: $selectedPersons)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image(systemName: "xmark")
                            .onTapGesture {
                                withAnimation(.easeOut) {
                                    isPopup.toggle()
                                }
                            }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add") {
                            withAnimation(.easeOut) {
                                isPopup.toggle()
                                addPersonsToGroup()
                            }
                        }
                    }
                }
        }
    }
    
    private func createGroup() {
        group.id = UUID()
        group.title = newTitle
        group.theme = newColorTheme.rawValue
        print(group)
        try? childContext.save()
        childContext.parent?.saveContext()
        print("create method")
        dismiss()
        
    }
    
    private func updateGroup() {
        try? childContext.save()
        childContext.parent?.saveContext()
        print("update method")
        dismiss()
        
    }
    
    private func deleteGroup() {
        childContext.delete(group)
        try? childContext.save()
        dismiss()
    }
    
    private func addPersonsToGroup() {
        for person in selectedPersons {
            person.addToGroups(group)
        }
        try? childContext.save()
    }
}

struct GroupEditView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        let viewContext = persistenceController.container.viewContext
        
        let group = Groups(context: viewContext)
        group.title = "Test"
        
        let person1 = Person(context: viewContext)
        person1.firstName = "John"
        person1.lastName = "Doe"
        person1.birthday = Date()
        
        
        let person2 = Person(context: viewContext)
        person2.firstName = "Jane"
        person2.lastName = "Smith"
        person2.birthday = Date()
        
        person1.addToGroups(group)
        person2.addToGroups(group)
        
        
        return GroupEditView(group: group, isEdit: true)
            .environment(\.managedObjectContext, viewContext)
    }
}
