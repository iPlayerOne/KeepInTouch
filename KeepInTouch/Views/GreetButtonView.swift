//
//  GreetButtonView.swift
//  KeepInTouch
//
//  Created by ikorobov on 12.10.2023.
//

import SwiftUI

struct GreetButtonView: View {
    let activeColor = Color.red
    let inactiveColor = Color.gray
    
    var isActive: Bool
    
    var body: some View {
        Button(action: {}) {
            Text("Greet")
                .frame(maxWidth: .infinity)
                .padding()
                .background(isActive ? activeColor : inactiveColor)
                .foregroundColor(.white)
                .cornerRadius(15)
        }
        .disabled(!isActive)
    }
}

#Preview {
    GreetButtonView(isActive: false)
}
