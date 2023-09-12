//
//  ColorTheme.swift
//  KeepInTouch
//
//  Created by ikorobov on 20.02.2023.
//

import SwiftUI

public enum ColorTheme: Int16, CaseIterable, Identifiable, Codable {
    case bubblegum = 0
    case buttercup = 1
    case indigo = 2
    case lavender = 3
    case magenta = 4
    case navy = 5
    case orange = 6
    case oxblood = 7
    case periwinkle = 8
    case poppy = 9
    case purple = 10
    case seafoam = 11
    case sky = 12
    case tan = 13
    case teal = 14
    case yellow = 15
    
    var accentColor: Color {
        switch self {
            case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
            case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    
    
//    func mainColor(forRawValue rawValue: Int16) {
//        Color(name)
//    }
    var mainColor: Color {
        Color(self.name.lowercased())
    }

    var name: String {
        String(describing: self)
    }
    
    public var id: String {
        name
    }
    
    var nsManagedTheme: Int16 {
        self.rawValue
    }
}
    
