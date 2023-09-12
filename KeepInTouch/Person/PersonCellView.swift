//
//  PersonCellView.swift
//  KeepInTouch
//
//  Created by ikorobov on 26.02.2023.
//

import SwiftUI

struct PersonCellView: View {
    
    @ObservedObject var person: Person
    var isSelected: Bool
    var toggleSelection: (Person) -> Void
    var viewMode: ViewMode

    var body: some View {
        HStack {
            if viewMode == .navigation {
                //            GroupIconView(title: person.firstName, theme: theme)
                //                .font(.title)
                //                .scaledToFit()
                NavigationLink(destination: PersonDetailView(person: person)) {
                    Text(person.fullName)
                }
            } else {
                Text(person.fullName)
                    .onTapGesture {
                        toggleSelection(person)
                    }
            }
            Spacer()
            
            if viewMode == .selection {
                Button(action: {toggleSelection(person)}) {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                }
            }
        }
        .frame(height: 30)
    }
}

struct PersonCellView_Previews: PreviewProvider {
    static var previews: some View {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.viewContext
        let sample = Sample()
        let newPerson = Person(context: viewContext)
        newPerson.id = UUID()
        newPerson.firstName = sample.firstNames.randomElement() ?? ""
        newPerson.lastName = sample.lastNames.randomElement() ?? ""
        newPerson.birthday = Date()

        viewContext.saveContext()

        return  PersonCellView(person: newPerson, isSelected: true, toggleSelection: {_ in}, viewMode: .selection)
            .environment(\.managedObjectContext, viewContext)    }
}


