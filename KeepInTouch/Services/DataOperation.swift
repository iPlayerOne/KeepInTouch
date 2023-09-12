//
//  DataOperation.swift
//  KeepInTouch
//
//  Created by ikorobov on 06.09.2023.
//

import Foundation
import CoreData

struct CreateOperation<Object: NSManagedObject>: Identifiable {
    let id = UUID()
    let childContext: NSManagedObjectContext
    let childObject: Object
    
    init(with parentContext: NSManagedObjectContext) {
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType) // Create child context
        childContext.parent = parentContext
        let childObject = Object(context: childContext)
        self.childContext = childContext
        self.childObject = childObject
    }
}

struct UpdateOperation<Object: NSManagedObject>: Identifiable {
    let id = UUID()
    let childContext: NSManagedObjectContext
    let childObject: Object
    
    init(
        withExisting object: Object,
        in parentContext: NSManagedObjectContext
    ) {
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = parentContext
        let childObject = childContext.object(with: object.objectID) as! Object
        
        self.childContext = childContext
        self.childObject = childObject
    }
}
