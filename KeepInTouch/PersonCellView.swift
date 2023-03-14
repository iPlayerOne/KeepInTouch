//
//  PersonCellView.swift
//  KeepInTouch
//
//  Created by ikorobov on 26.02.2023.
//

import SwiftUI

struct PersonCellView: View {
    let title: String
    let name: String
    let theme: ColorTheme
    
    var body: some View {
        HStack {
            GroupIconView(title: title, theme: theme)
                .font(.title)
                .scaledToFit()
            Spacer()
            Text(name)
                .font(.title)
        }
        .frame(height: 60)
    }
}

struct PersonCellView_Previews: PreviewProvider {
    static var previews: some View {
        PersonCellView(title: "WT", name: "What the fuck", theme: ColorTheme.indigo)
    }
}
