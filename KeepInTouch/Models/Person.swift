//
//  Person.swift
//  KeepInTouch
//
//  Created by ikorobov on 20.02.2023.
//

import Foundation

extension Person {
    
     //some wrapped properties
    
    var firstName: String {
        get { firstName_ ?? "No Name" }
        set { firstName_ = newValue }
    }
    
    var lastName: String {
        get { lastName_ ?? "No Last Name"}
        set { lastName_ = newValue }
    }
    
    var birthday: Date {
        get { birthday_ ?? Date() }
        set { birthday_ = newValue }
    }
    
    var fullName: String {
        return "\(firstName_ ?? "Full") \(lastName_ ?? "Name")"
    }
}





