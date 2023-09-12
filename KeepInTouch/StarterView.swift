//
//  StarterView.swift
//  KeepInTouch
//
//  Created by ikorobov on 21.02.2023.
//

import SwiftUI

struct StarterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isGroups = false
    @State private var showNotificationPermissionAlert = false
    @State private var hasNotificationPermission = false
    @State private var selectedView: Int = 1
    
    
    var body: some View {
        NavigationView {
            ZStack{
//                if isGroups {
//                    TempGroupListView()
////                    GridView()
//                } else {
//                    TempPersonListView()
//                }
                TabView(selection: $selectedView) {
                    TempGroupListView()
                        .tag(0)
                        .tabItem {
                            Image(systemName: "person.2.crop.square.stack")
                            Text("Groups")
                        }
                    EventsMainView()
                        .tag(1)
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("Events")
                        }
                    TempPersonListView(viewMode: .navigation)
                        .tag(2)
                        .tabItem {
                            Image(systemName: "person.crop.rectangle.stack")
                            Text("Persons")
                        }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
//            .toolbar {
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        isGroups.toggle()
//                    }) {
//                        Label("", systemImage: isGroups ? "person.2.crop.square.stack" : "person.crop.rectangle.stack" )
//                    }
//                }
//            }
            .alert(isPresented: $showNotificationPermissionAlert) {
                Alert(
                    title: Text("Notification request"),
                    message: Text("Wanna some notification, bro?"),
                    primaryButton: .default(Text("Cool!")) {
                        
                    },
                    secondaryButton: .cancel()
                )
            }
            .onAppear {
                NotificationController.shared.requestPermission { granted in
                    if !granted {
                        showNotificationPermissionAlert = true
                    }
                    hasNotificationPermission = granted
                }
            }
        }
    }
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.viewContext
        for i in 0..<6 {
            let newPerson = Person(context: viewContext)
            newPerson.id = UUID()
            newPerson.firstName = "Kot \(i)"
            newPerson.lastName = "Kotovich"
            
            let newGroup = Groups(context: viewContext)
            newGroup.id = UUID()
            newGroup.title = "Group \(i)"
            newGroup.theme = Int16(i)
        }
        viewContext.saveContext()
        return StarterView()
            .environment(\.managedObjectContext, viewContext)
    }
}
