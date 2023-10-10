//
//  PersonEditView.swift
//  KeepInTouch
//
//  Created by ikorobov on 10.03.2023.
//

import SwiftUI

struct PersonAddEditView: View {
    
    @Environment(\.managedObjectContext) private var childContext
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var person: Person
    
    @State private var newFirstName = ""
    @State private var newLastName = ""
    @State private var newBirthday = Date()
    
    @State var isEdit: Bool
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: isEdit ? $person.firstName : $newFirstName)
                    TextField("Last Name", text:  isEdit ? $person.lastName : $newLastName)
                    DatePicker("Birthday", selection: isEdit ? $person.birthday : $newBirthday, displayedComponents: .date)
                }
                
                //                        Section(header: Text("Events")) {
                //                            ForEach($data.events) { $event in
                //                                Text(event.title)
                //                            }
                //                            Button {
                //                                data.events.append(Person.Event(id: UUID(), title: "", date: Date()))
                //                            } label: {
                //                                Text("Add Event")
                //                            }
                //
                //                        }
                
                //                        Section(header: Text("Meetings")) {
                //                                ForEach($data.meetings) { $meeting in
                //                                    Text("\(meeting.date)")
                //                            }
                //                            Button {
                //                                data.meetings.append(Person.Meeting(id: UUID(), date: Date()))
                //                            } label: {
                //                                Text("Add meeting")
                //                            }
                //
                //                        }
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            savePerson()
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
                            deletePerson()
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
                .navigationBarTitle(isEdit ? "Edit Person" : "Create Person")
            }
            
        }
    }
    
    private func savePerson() {
        withAnimation {
            if isEdit {
                try? childContext.save()
                childContext.parent?.saveContext()
                dismiss()
            } else {
                person.id = UUID()
                person.firstName = newFirstName
                person.lastName = newLastName
                person.birthday = newBirthday
                try? childContext.save()
                childContext.parent?.saveContext()
                dismiss()
            }
        }
        scheduleBirthdayNotification()
    }
    
    private func deletePerson() {
        childContext.delete(person)
        try? childContext.save()
        dismiss()
    }
    
    private func scheduleBirthdayNotification() {
        let calendar = Calendar.current
        let birthdayComponents = calendar.dateComponents([.month, .day], from: isEdit ? person.birthday : newBirthday)
        guard let month = birthdayComponents.month, let day = birthdayComponents.day else { return }
        
        let notificationTime = DateComponents(month: month, day: day, hour: 12, minute: 0)
        let title = "Birtday"
        let body = "\(isEdit ? person.fullName : newFirstName) birthday"
        
        NotificationController.shared.schelduleNotification(title: title, body: body, dateComponents: notificationTime)
    }
}

struct PersonEditView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let newPerson = Person(context: context)
        
        return PersonAddEditView(person: newPerson, isEdit: false)
            .environment(\.managedObjectContext, context)
    }
}

