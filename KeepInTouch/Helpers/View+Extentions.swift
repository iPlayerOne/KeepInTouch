//
//  View+Extentions.swift
//  KeepInTouch
//
//  Created by ikorobov on 22.10.2023.
//

import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
