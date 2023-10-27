//
//  PersonEditView.swift
//  KeepInTouch
//
//  Created by ikorobov on 10.03.2023.
//

import SwiftUI
import Contacts

struct PersonAddEditView: View {
    
    @Environment(\.managedObjectContext) private var childContext
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var person: Person
    
    @State var isEdit: Bool
    @State private var showContactPicker = false
    @State private var showBirthdayEventAlert = false
    @State private var isBirthdayDateChanged = false
    
    @State private var selectedContacts: CNContact?
    
    @State private var newFirstName = ""
    @State private var newLastName = ""
    @State private var newPhoneNumber = ""
    @State private var newEmail = ""
    @State private var newBirthday = Date()
    
    @FocusState private var focusedField: Field?

    
    var body: some View {
        
        Form {
            Button(action: {
                ContactService().requestAccess { granted in
                    if granted {
                        showContactPicker = true
                    } else {
                        print("Access denied")
                    }
                }
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Import from Contacts")
                }
            }
            
            Section(header: Text("Personal Information")) {
                TextField("First Name", text: isEdit ? $person.firstName : $newFirstName)
                    .focused($focusedField, equals: .firstName)
                    .textFieldStyle(.plain)
                TextField("Last Name", text:  isEdit ? $person.lastName : $newLastName)
                    .focused($focusedField, equals: .lastName)
                    .textFieldStyle(.plain)
            }
            Section(header: Text("Contact information")) {
                TextField("Phone Number", text: isEdit ? $person.phoneNumber : $newPhoneNumber)
                    .focused($focusedField, equals: .phoneNumber)
                    .keyboardType(.phonePad)
                    .textFieldStyle(.plain)
                TextField("email", text: isEdit ? $person.email : $newEmail )
                    .focused($focusedField, equals: .email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(.plain)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                DatePicker("Birthday", selection: isEdit ? $person.birthday : $newBirthday, displayedComponents: .date)
                    .focused($focusedField, equals: .birthday)
//                    .onTapGesture {
//                        hideKeyboard()
//                    }
//                    .onChange(of: isEdit ? person.birthday : newBirthday) { _ in
//                                isBirthdayDateChanged = true
//                    }
            }
            EditCreateButtonsView(isEdit: isEdit) {
                savePerson()
            } cancelAction: {
                childContext.rollback()
                dismiss()
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarTitle(isEdit ? "Edit Person" : "Create Person")
            .sheet(isPresented: $showContactPicker) {
                ContactPicker(selectedContact: $selectedContacts)
            }
            .onChange(of: selectedContacts) { contact in
                if let contact = contact {
                    if !isEdit {
                        newFirstName = contact.givenName
                        newLastName = contact.familyName
                    }
                    if let birthday = contact.birthday {
                        newBirthday = Calendar.current.date(from: birthday) ?? Date()
                    }
                }
            }
            .alert(isPresented: $showBirthdayEventAlert) {
                Alert(title: Text("Birthday!"),
                      message: Text("We have norticed that you add birthday date for the contact. Do you want to create event?"),
                      primaryButton: .default(Text("Yes")) {
                    
                    let newEvent = createBirthdayEvent()
                    newEvent.addToPersons(person)
                    scheduleBirthdayNotification(for: newEvent.notificationID ?? UUID().uuidString)
                    
                },
                      secondaryButton: .cancel()
                )
            }
        }
    }

    
    private func savePerson() {
        if !isEdit {
            person.id = UUID()
            person.firstName = newFirstName
            person.lastName = newLastName
            person.birthday = newBirthday
            person.email = newEmail
            person.phoneNumber = newPhoneNumber
        }
        
        if isBirthdayDateChanged {
            showBirthdayEventAlert = true
        }
        
        try? childContext.save()
        childContext.parent?.saveContext()
        
        isBirthdayDateChanged = false
        
        dismiss()
        
    }
    
    private func deletePerson() {
        childContext.delete(person)
        try? childContext.save()
        dismiss()
    }
    
    private func createAndSavePerson() {
        person.id = UUID()
        person.firstName = newFirstName
        person.lastName = newLastName
        person.birthday = newBirthday
        person.email = newEmail
        person.phoneNumber = newPhoneNumber
    }
    
    private func createBirthdayEvent() -> Event {
        let newEvent = Event(context: childContext)
        newEvent.id = UUID()
        newEvent.category = "Birthday"
        newEvent.notificationID = UUID().uuidString
        newEvent.date = newBirthday
        return newEvent
    }
    
    private func scheduleBirthdayNotification(for identifier: String) {
        let calendar = Calendar.current
        let birthdayComponents = calendar.dateComponents([.month, .day], from: isEdit ? person.birthday : newBirthday)
        guard let month = birthdayComponents.month, let day = birthdayComponents.day else { return }
    
        let notificationTime = DateComponents(month: month, day: day, hour: 12, minute: 0)
        let title = "Birtday"
        let body = "\(isEdit ? person.fullName : newFirstName) birthday"
    
        NotificationController.shared.schelduleNotification(identifier: identifier, title: title, body: body, dateComponents: notificationTime)
    }
}

extension PersonAddEditView {
   private enum Field: Hashable {
        case firstName, lastName, phoneNumber, email, birthday
    }
    
    private func previousField() {
        switch focusedField {
            case .some(.firstName):
                focusedField = .email
            case .some(.lastName):
                focusedField = .firstName
            case .some(.phoneNumber):
                focusedField = .lastName
            case .some(.email):
                focusedField = .phoneNumber
            case .some(.birthday):
                focusedField = .email
            case .none:
                focusedField = nil
        }
    }
    
    private func nextField() {
        switch focusedField {
            case .some(.firstName):
                focusedField = .lastName
            case .some(.lastName):
                focusedField = .phoneNumber
            case .some(.phoneNumber):
                focusedField = .email
            case .some(.email):
                focusedField = .birthday
            case .some(.birthday):
                focusedField = .firstName
            case .none:
                focusedField = nil

        }
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

