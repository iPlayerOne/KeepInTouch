//
//  CoreDataExtentions.swift
//  KeepInTouch
//
//  Created by ikorobov on 05.07.2023.
//

import CoreData

extension NSManagedObjectContext {
    func saveContext() {
        if self.hasChanges {
            do {
                try self.save()
                print("moc extention save")
            } catch {
                let nsError = error as NSError
                print("Error while saving managed object context: \(nsError), \(nsError.userInfo)")
//                fatalError("Some error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

