//
//  DateFormatterHelper.swift
//  KeepInTouch
//
//  Created by ikorobov on 27.09.2023.
//

import Foundation

struct DateFormatterHelper {
    
    static let shared = DateFormatterHelper()
    
    private let dateFormatter = DateFormatter()
    
    private init() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }
    
    func format(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
}
