//
//  RoundButtonView.swift
//  KeepInTouch
//
//  Created by ikorobov on 01.10.2023.
//

import SwiftUI

struct ButtonView: View {
    
    var action: () -> Void
    var imageString: String
    var color: Color
    
    var body: some View {
        Button(action: action) {
            Image(systemName: imageString)
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(color)
        }
    }
}

#Preview {
    ButtonView(action: {}, imageString: "plus.circle.fill", color: .blue)
}
