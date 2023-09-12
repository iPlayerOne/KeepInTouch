//
//  KeepInTouchApp.swift
//  KeepInTouch
//
//  Created by ikorobov on 07.02.2023.
//

import SwiftUI

@main
struct KeepInTouchApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    
    //    init() {
    //        persistanceController.resetPersistentStore()
    //    }
    
    var body: some Scene {
        WindowGroup {
            StarterView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    persistenceController.container.viewContext.saveContext()
                    print("AppFile notification save")
                }
                .onChange(of: scenePhase) { _ in
                    try? persistenceController.container.viewContext.save()
                    print("onChange savien method")
                }
        }
    }
}
