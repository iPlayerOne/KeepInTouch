////
////  PersonListView.swift
////  KeepInTouch
////
////  Created by ikorobov on 23.02.2023.
////
//
//import SwiftUI
//
//struct PersonListView: View {
//    
//    @Environment(\.managedObjectContext) private var viewContext
//    @Environment(\.presentationMode) var presentationMode
//    
//    @FetchRequest(entity: Person.entity(), sortDescriptors: [NSSortDescriptor(key: "lastName_", ascending: true)])
//    private var allPersons: FetchedResults<Person>
//    @State var isGrouped: Bool
//    @ObservedObject var group: Groups
//    
//    
//    var body: some View {
//        VStack {
//            if isGrouped {
//                GroupIconView(
//                    title: group.title,
//                    theme: ColorTheme(
//                        rawValue: (group.colorTheme).rawValue) ?? ColorTheme.magenta
//                )
//                .frame(maxHeight: 250)
//                .padding()
//                
//                EventFooterView()
//                    .padding()
//                ScrollView {
//                    LazyVStack {
//                        if let persons = group.persons?.allObjects as? [Person] {
//                            ForEach(persons) { person in
////                                PersonCellView(
////                                    title: "\(person.zfirstName.first ?? "I")" + "\(person.lastName.first ?? "K")",
////                                    name: person.fullName,
////                                    theme: ColorTheme.allCases.randomElement() ?? ColorTheme.indigo)
//                                Divider()
//                            }
//                        }
//                    }
//                    .padding()
//                }
//                .padding(.top)
//                .background(Color.mint)
//                .navigationBarTitle("Friends")
//            } else {
//                ScrollView {
//                    LazyVStack {
//                        ForEach(allPersons) { person in
////                            PersonCellView(
////                                title: "\(person.firstName.first ?? "I")" + "\(person.lastName.first ?? "K")",
////                                name: person.fullName,
////                                theme: ColorTheme.indigo)
//                            Divider()
//                        }
//                    }
//                    .padding()
//                }
//            }
//        }
//    }
//}
//
//struct PersonListView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.viewContext
//        
//        
//        // Создаем тестовых Persons
//        let person1 = Person(context: viewContext)
//        person1.firstName = "John"
//        person1.lastName = "Doe"
//        
//        let person2 = Person(context: viewContext)
//        person2.firstName = "Jane"
//        person2.lastName = "Smith"
//        
//        // Создаем тестовый Group
//        let newGroup = Groups(context: viewContext)
//        newGroup.id = UUID()
//        newGroup.title = "Friends Group"
//        newGroup.colorTheme = ColorTheme.bubblegum // Предположим, у вас есть соответствующий enum
//        
//        // Добавляем Persons в Group
//        newGroup.addToPersons(NSSet(array: [person1, person2]))
//        
//        // Возвращаем представление для превью с заданными тестовыми данными
//        return PersonListView(isGrouped: false, group: newGroup)
//            .environment(\.managedObjectContext, viewContext)
//    }
//}

