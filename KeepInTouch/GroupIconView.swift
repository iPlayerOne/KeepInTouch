//
//  ContentView.swift
//  KeepInTouch
//
//  Created by ikorobov on 07.02.2023.
//

import SwiftUI

struct GroupIconView: View {
    let group: [Person] = Sample.sampleData
    let title: String
    let theme: ColorTheme
    
    var body: some View {
            GeometryReader { geometry in
                NavigationLink(destination: , label: <#T##() -> _#>) {
                    Circle()
                        .strokeBorder(theme.accentColor, lineWidth: geometry.size.width * 0.02)
                        .background(Circle().foregroundColor(theme.mainColor))
        //                .frame(width: 150)
                        .shadow(color: theme.accentColor, radius: geometry.size.width * 0.03, y: 0)
                        .overlay {
                            Text(title)
                                .font(.title)
                                .foregroundColor(theme.accentColor)
                    }
                }
            }


    }
}

struct GroupIconView_Previews: PreviewProvider {
    static var previews: some View {
        GroupIconView(title: "Test", theme: .magenta)
    }
}
