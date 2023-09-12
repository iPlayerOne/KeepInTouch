//
//  ThemeView.swift
//  KeepInTouch
//
//  Created by ikorobov on 15.03.2023.
//

import SwiftUI

struct GroupThemeView: View {
    let theme: ColorTheme
    let color: Color
    
    var body: some View {
        HStack {
            Text(theme.name)
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
        }
        .tag(theme)
    }
}
//            RoundedRectangle(cornerRadius: 4)
//            //                .fill(theme.mainColor)
//            Circle()
//                .fill(theme.mainColor)
//                .frame(width: 20, height: 20)
//            Label(theme.name, systemImage: "paintpalette")
//                .padding(4)
//        .foregroundColor(theme.accentColor)
//        .fixedSize(horizontal: false, vertical: true)
//    }
//}

struct GroupThemeView_Previews: PreviewProvider {
    static var previews: some View {
        GroupThemeView(theme: .navy, color: .cyan)
    }
}
