//
//  ContactStackView.swift
//  KeepInTouch
//
//  Created by ikorobov on 12.10.2023.
//

import SwiftUI

struct ContactStackView: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Divider()
        HStack(spacing: 15) {
            ContactButtonView(image: "phone.fill", color: .gray, text: "call", width: width, height: height)
            ContactButtonView(image: "bubble.right.fill", color: .gray, text: "message", width: width, height: height)
            ContactButtonView(image: "envelope.fill", color: .gray, text: "email", width: width, height: height)
            ContactButtonView(image: "paperplane.fill", color: .gray, text: "telegram", width: width, height: height)
        }
        Divider()
    }
}

#Preview {
    ContactStackView(width: 40, height: 40)
}
