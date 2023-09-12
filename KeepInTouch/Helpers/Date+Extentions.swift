//
//  Date+Extentions.swift
//  KeepInTouch
//
//  Created by ikorobov on 29.09.2023.
//

import Foundation

extension Date {
    
    var formatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self)
    }
    
    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components) ?? self
    }
    
    var endOfMonth: Date {
        let calendar = Calendar.current
        if let startOfNextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth) {
            return calendar.date(byAdding: .day, value: -1, to: startOfNextMonth) ?? self
        }
        return self
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    func isThisMonth() -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: Date(), toGranularity: .month)
    }
    
//MARK: - testing methods
    
    func randomDate() -> Date {
        let currentDate = Date()
        let oneYearInSeconds: TimeInterval = 365.25 * 24 * 60 * 60
        let randomInterval = TimeInterval.random(in: -oneYearInSeconds ... -oneYearInSeconds*0.1)
        return currentDate.addingTimeInterval(randomInterval)
    }
    
    func randomDateUntilMonthEnds() -> Date {
        let calendar = Calendar.current
        let currentDate = Date()
        
        if let lastDay = calendar.date(byAdding: DateComponents(month: 1, day: -1),to: currentDate.startOfMonth) {
            let interval = lastDay.timeIntervalSince(currentDate)
            let randomInterval = TimeInterval.random(in: 0...interval)
            return currentDate.addingTimeInterval(randomInterval)
        } else {
            return Date()
        }
    }
    
}
