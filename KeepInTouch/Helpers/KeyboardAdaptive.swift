//
//  KeyboardAdaptive.swift
//  KeepInTouch
//
//  Created by ikorobov on 22.10.2023.
//

import SwiftUI

struct KeyboardAdaptive: ViewModifier {
    @ObservedObject private var keyboard = KeyboardResponder()
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboard.currentHeight)
            .animation(.easeInOut, value: 0.3)
    }
}
