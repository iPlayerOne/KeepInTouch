//
//  EditCreateButtonsView.swift
//  KeepInTouch
//
//  Created by ikorobov on 18.10.2023.
//

import SwiftUI

struct EditCreateButtonsView: View {
    @State var isEdit: Bool
    var confirmAction: () -> Void
    var cancelAction: () -> Void
    
    var body: some View {
        Section {
            HStack(spacing: 20) {
                Button(action: {
                    confirmAction()
                }) {
                    Text(isEdit ? "Done" : "Create")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                    .background(Color.gray)
                    .padding(.horizontal, 5)
                
                Button(action: {
                    cancelAction()
                }) {
                    Text("Cancel")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    Group {
        EditCreateButtonsView(isEdit: false, confirmAction: {}, cancelAction: {})
        EditCreateButtonsView(isEdit: true, confirmAction: {}, cancelAction: {})
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
