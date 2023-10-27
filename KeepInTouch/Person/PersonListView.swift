//
//  TempPersonListView.swift
//  KeepInTouch
//
//  Created by ikorobov on 10.09.2023.
//

import SwiftUI

struct PersonListView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Person.entity(), sortDescriptors: [NSSortDescriptor(key: "firstName_", ascending: true)])
    private var persons: FetchedResults<Person>
    
    @Binding var selectedPersons: [Person]
    @State private var createOperation: CreateOperation<Person>?
    @State private var isAddPersonShow: Bool = false
    @State private var viewMode: ViewMode
    @State private var searchText: String = ""
//    var query: Binding<String> {
//        Binding {
//            searchText
//        } set: { newValue in
//            searchText = newValue
//            persons.nsPredicate = newValue.isEmpty
//            ? nil
//            : NSPredicate(format: "place CONTAINS %@", newValue)
//        }
//    }
    
    init(viewMode: ViewMode = .navigation, selectedPersons: Binding<[Person]> = .constant([])) {
        _viewMode = State(initialValue: viewMode)
        _selectedPersons = selectedPersons
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Search", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
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
                .onChange(of: searchText) { newValue in
                            persons.nsPredicate = newValue.isEmpty ? nil : NSPredicate(format: "firstName_ CONTAINS %@ OR lastName_ CONTAINS %@ ", newValue, newValue)
                        }
            
            }
            if viewMode == .navigation {
                
                VStack {
                    TextField("Search", text: $searchText)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .opacity(0.8)
                    Spacer()
                    HStack {
                         RoundButtonView(action: deleteAllPerson, imageString: "minus.square.fill", color: .red)
                            .padding()
                        Spacer()
                         RoundButtonView(action: PersistenceController.shared.createMockPerson, imageString: "plus.app.fill", color: .gray)
                            .padding()
                         RoundButtonView(action: addPerson, imageString: "plus.circle.fill", color: .blue)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Persons")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(item: $createOperation) { createOperation in
            NavigationView {
                PersonAddEditView(person: createOperation.childObject, isEdit: false)
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
        
        return PersonListView()
            .environment(\.managedObjectContext, viewContext)
    }
}
