//
//  PersonEditView.swift
//  KeepInTouch
//
//  Created by ikorobov on 10.03.2023.
//

import SwiftUI

struct PersonEditView: View {
    
    @Binding var data: Person.Data
    @Binding var group: Person.Group?
    @State private var firstName = ""
    @State private var lastName = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    DatePicker("Birthday", selection: $data.birthday, displayedComponents: .date)
                }
                
                Section(header: Text("Events")) {
                    ForEach($data.events) { $event in
                        Text(event.title)
                    }
                    Button {
                        data.events.append(Person.Event(id: UUID(), title: "", date: Date()))
                    } label: {
                        Text("Add Event")
                    }

                }
                
                Section(header: Text("Meetings")) {
                        ForEach($data.meetings) { $meeting in
                            Text("\(meeting.date)")
                    }
                    Button {
                        data.meetings.append(Person.Meeting(id: UUID(), date: Date()))
                    } label: {
                        Text("Add meeting")
                    }

                }
                
                Section {
                    Button(action: {
                        data.firstName = firstName
                        data.lastName = lastName
                    }, label: {
                        Text("Save")
                    })
                }
            }
        }
    }
}

struct PersonEditView_Previews: PreviewProvider {
    static var previews: some View {
        PersonEditView(data: .constant(Sample.sampleData[0].data), group: .constant(Sample.sampleGroups[0]))
    }
}
