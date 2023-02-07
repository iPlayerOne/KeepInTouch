//
//  GridView.swift
//  KeepInTouch
//
//  Created by ikorobov on 21.02.2023.
//

import SwiftUI

struct GridView: View {
    let groups = Sample.sampleData
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                    ForEach(groups) { group in
                        GroupIconView(title: group.title, theme: group.colorTheme)
                            .scaledToFit()
                    }
                }
            }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
