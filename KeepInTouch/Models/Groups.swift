//
//  Groups.swift
//  KeepInTouch
//
//  Created by ikorobov on 21.07.2023.
//

import Foundation

extension Groups {
    
    var title: String {
        get { title_ ?? "no title" }
        set { title_ = newValue }
    }
    
    var theme: Int16 {
        get { theme_ }
        set { theme_ = newValue }
    }
    
    var personsArray: [Person] {
        let set = persons as? Set<Person> ?? []
        return Array(set)
    }
    
    var colorTheme: ColorTheme {
        get {
            ColorTheme(rawValue: theme) ?? .bubblegum
        }
        set {
            theme = newValue.rawValue
        }
    }
    
    static func delete(at offsets: IndexSet, for groups:[Groups]) {
        if let first = groups.first, let context = first.managedObjectContext {
            offsets.map { groups[$0] }.forEach(context.delete)
            context.saveContext()
        }
    }
}
