//
//  PersonAddView.swift
//  KeepInTouch
//
//  Created by ikorobov on 04.09.2023.
//

import SwiftUI
// Bridge to PersonEditView. Making new GroupEntity
struct PersonAddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    //State of new entity
    @State private var newPerson: Person? = nil
    
    var body: some View {
        //Use group because swift won't let us
        Group {
            if let person = newPerson {
                PersonAddEditView(person: person, isEdit: false)
            } else {
                ProgressView()
                    .onAppear {
                        newPerson = Person(context: viewContext)
                    }
            }
        }
        .navigationBarHidden(true)
    }
}

struct PersonAddView_Previews: PreviewProvider {
    static var previews: some View {
        PersonAddView()
    }
}
