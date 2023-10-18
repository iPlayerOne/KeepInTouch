//
//  ContactsImporter.swift
//  KeepInTouch
//
//  Created by ikorobov on 10.10.2023.
//

import SwiftUI
import ContactsUI

struct ContactPicker: UIViewControllerRepresentable {
    
    @Binding var selectedContact: CNContact?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
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
        
        private func contactPicker(_ picker: CNContactPickerDelegate, didSelect contact: CNContact) {
            parent.selectedContact = contact
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
}

