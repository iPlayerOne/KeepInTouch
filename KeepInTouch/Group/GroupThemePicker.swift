//
//  ThemePicker.swift
//  KeepInTouch
//
//  Created by ikorobov on 15.03.2023.
//

import SwiftUI

struct GroupThemePicker: View {
    @Binding var selection: ColorTheme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(ColorTheme.allCases) { theme in
                GroupThemeView(theme: theme, color: selection.mainColor)
                    .tag(theme)
            }
        }
        .contentShape(Rectangle())
    }
}

struct GroupThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        GroupThemePicker(selection: .constant(.buttercup))
    }
}
