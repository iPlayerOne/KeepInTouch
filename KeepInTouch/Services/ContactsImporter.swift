//
//  ContactsImporter.swift
//  KeepInTouch
//
//  Created by ikorobov on 10.10.2023.
//

import SwiftUI
import Contacts
import ContactsUI


// Requesting control
class ContactService {
    
    private let contactStore = CNContactStore()
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        contactStore.requestAccess(for: .contacts) { granted, error in
            completion(granted)
        }
    }
}

// UI for picking contacts
struct ContactPicker: UIViewControllerRepresentable {
    
    @Binding var selectedContact: CNContact?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
//        picker.displayedPropertyKeys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactBirthdayKey]
        return picker
    }
    
    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, CNContactPickerDelegate {
        var parent: ContactPicker
        
        init(_ parent: ContactPicker) {
            self.parent = parent
        }
        
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            parent.selectedContact = contact
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
}

