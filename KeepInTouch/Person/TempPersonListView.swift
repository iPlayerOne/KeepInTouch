//
//  TempPersonListView.swift
//  KeepInTouch
//
//  Created by ikorobov on 10.09.2023.
//

import SwiftUI

struct TempPersonListView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Person.entity(), sortDescriptors: [NSSortDescriptor(key: "firstName_", ascending: true)])
    private var persons: FetchedResults<Person>
    
    @Binding var selectedPersons: [Person]
    @State private var createOperation: CreateOperation<Person>?
    @State private var isAddPersonShow: Bool = false
    @State private var viewMode: ViewMode
    
    init(viewMode: ViewMode = .navigation, selectedPersons: Binding<[Person]> = .constant([])) {
        _viewMode = State(initialValue: viewMode)
        _selectedPersons = selectedPersons
    }
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            List {
                ForEach(persons) { person in
                    let isSelected = selectedPersons.contains { $0.id == person.id}
                    
                    if viewMode == .navigation {
                        PersonCellView(person: person, isSelected: isSelected, toggleSelection: { _ in}, viewMode: viewMode)
                            .swipeActions {
                                Button(role: .destructive) {
                                    deletePerson(person)
                                } label: {
                                    Label("Delete",systemImage: "trash")
                                }

                            }
                    } else {
                        PersonCellView(person: person, isSelected: isSelected, toggleSelection: { selectedPerson in
                            handlePersonSelection(selectedPerson)
                        }, viewMode: viewMode)
                    }
                }
            }
            if viewMode == .navigation {
                
                VStack {
                    Spacer()
                    HStack {
                        ButtonView(action: deleteAllPerson, imageString: "minus.square.fill", color: .red)
                            .padding()
                        Spacer()
                        ButtonView(action: PersistenceController.shared.createMockPerson, imageString: "plus.app.fill", color: .gray)
                            .padding()
                        ButtonView(action: addPerson, imageString: "plus.circle.fill", color: .blue)
                    }
                    .padding()
                }
            }
        }
        .sheet(item: $createOperation) { createOperation in
            NavigationView {
                PersonEditView(person: createOperation.childObject, isEdit: false)
                    .environment(\.managedObjectContext, createOperation.childContext)
            }
        }
    }
    
    private func addPerson() {
        isAddPersonShow = true
        createOperation = CreateOperation(with: viewContext)
    }
    
    private func deletePerson(_ person: Person ) {
        viewContext.delete(person)
        viewContext.saveContext()
    }
    
    private func deleteAllPerson() {
        for person in persons {
            viewContext.delete(person)
        }
        viewContext.saveContext()
        
    }
    
    private func toggleSelectedPerson(_ person: Person) {
        if let index = selectedPersons.firstIndex(where: { $0.id == person.id }) {
            selectedPersons.remove(at: index)
        } else {
            selectedPersons.append(person)
        }
    }
    
    private func handlePersonSelection(_ person: Person) {
        toggleSelectedPerson(person)
    }
}

struct TempPersonListView_Previews: PreviewProvider {
    static var previews: some View {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.viewContext
        let sample = Sample()
        for _ in 0..<6 {
            let newPerson = Person(context: viewContext)
            newPerson.id = UUID()
            newPerson.firstName = sample.firstNames.randomElement() ?? ""
            newPerson.lastName = sample.lastNames.randomElement() ?? ""
            newPerson.birthday = Date()
        }
        viewContext.saveContext()
        
        return TempPersonListView()
            .environment(\.managedObjectContext, viewContext)
    }
}
