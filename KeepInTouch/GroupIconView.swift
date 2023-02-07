//
//  ContentView.swift
//  KeepInTouch
//
//  Created by ikorobov on 07.02.2023.
//

import SwiftUI

struct GroupIconView: View {
    @State private var group: [Group] = Sample.sampleData
    let title: String
    let theme: ColorTheme
    
    var body: some View {
        VStack {
            Circle()
                .strokeBorder(theme.accentColor, lineWidth: 5)
                .background(Circle().foregroundColor(theme.mainColor))
//                .frame(width: 150)
                .shadow(radius: 10, y: 5)
                .overlay {
                    Text(title)
                        .font(.title)
                        .foregroundColor(theme.accentColor)
                }
        }
        .padding()
    }
}

struct GroupIconView_Previews: PreviewProvider {
    static var previews: some View {
        GroupIconView(title: "Test", theme: .magenta)
    }
}
