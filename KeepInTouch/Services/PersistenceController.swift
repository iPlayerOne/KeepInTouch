//
//  StorageManager.swift
//  KeepInTouch
//
//  Created by ikorobov on 15.03.2023.
//

import CoreData

class PersistenceController {
    
    //MARK: - Shared instance
    
    //Singleton to rule them all
    static let shared = PersistenceController()
    
    //MARK: - Properties
    //Core Data storage
    let container: NSPersistentContainer
    
    //Managed object context access
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    //MARK: - Initialization
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "GroupPersonModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
//        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unsolved Error \(error), \(error.userInfo)")
            }
        }
    }
    
    
    
    func resetPersistentStore() {
        // Delete existiong store
        let persistentStoreCoordinator = container.persistentStoreCoordinator
        for store in persistentStoreCoordinator.persistentStores {
            do {
                try persistentStoreCoordinator.remove(store)
            } catch {
                fatalError("Failed to remove persistent store: \(error)")
            }
        }

        // Creating new one
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Failed to create new persistent store: \(error)")
            }
        }
    }
    

        func save() {
            let context = container.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                    print("Persistence save")
                } catch {
                    fatalError("Something went wrong:\(error.localizedDescription)")
                }
            }
        }

        func updateGroup(_ group: Groups, withTitle newTitle: String, theme newColorTheme: Int16) {
            group.title = newTitle
            group.theme = newColorTheme
            save()
            print("persistence update")
        }

        func deleteGroup(_ group: Groups) {
            container.viewContext.delete(group)
            save()
            print("persistence delete")
        }
    
        //MARK: - mock objects
    
    func createMockGroup() {
        let sample = Sample()
        let newGroup = Groups(context: viewContext)
            newGroup.id = UUID()
            newGroup.title = sample.groupNames.randomElement() ?? "NO SAMPLE"
            newGroup.theme = Int16.random(in: Int16(0)...Int16(15))
        for _ in 1...3 {
            let newPerson = Person(context: viewContext)
            newPerson.id = UUID()
            newPerson.firstName = sample.firstNames.randomElement() ?? "No Name"
            newPerson.lastName = sample.lastNames.randomElement() ?? "No Name"
            
            newPerson.addToGroups(newGroup)
        }
            do {
                try viewContext.save()
            } catch {
                print("Some error: \(error.localizedDescription)")
            }
    }
    
    func createMockPerson() {
        let sample = Sample()
        let newPerson = Person(context: viewContext)
        newPerson.id = UUID()
        newPerson.firstName = sample.firstNames.randomElement() ?? "No Name"
        newPerson.lastName = sample.lastNames.randomElement() ?? "No Name"
        
        let fetchRequest: NSFetchRequest<Groups> = Groups.fetchRequest()
        if let allGroups = try? viewContext.fetch(fetchRequest), let randomGroup = allGroups.randomElement() {
            newPerson.addToGroups(randomGroup)
        }
        do {
            try viewContext.save()
        } catch {
            print("Some error: \(error.localizedDescription)")
        }
    }
    
    func createMockEvent() {
        let dates = [Date(), Date().randomDateUntilMonthEnds()]
        let newEvent = Event(context: viewContext)
        newEvent.id = UUID()
        newEvent.title = "title"
        newEvent.date = dates.randomElement()!
        
        let fetchPerson: NSFetchRequest<Person> = Person.fetchRequest()
        if let persons = try? viewContext.fetch(fetchPerson), let randomPerson = persons.randomElement() {
            newEvent.addToPersons(randomPerson)
        }
        viewContext.saveContext()
    }


}

