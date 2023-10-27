//
//  ContactButtonView.swift
//  KeepInTouch
//
//  Created by ikorobov on 12.10.2023.
//

import SwiftUI

struct ContactButtonView: View {
    
    let image: String
    let color: Color
    let text: String
    let width: CGFloat
    let height: CGFloat
    
    
    var body: some View {
        VStack {
            Button(action: {
        
                }) {
                    Image(systemName: image)
                        .frame(width: width, height: height)
                        .padding()
                        .background(color)
                        .foregroundColor(.white)
                        .clipShape(Circle())
            }
            Text(text)
        }
    }
}

#Preview {
    ContactButtonView(image: "phone.fill", color: .blue, text: "Call", width: 40, height: 40)
}
