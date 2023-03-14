//
//  StarterView.swift
//  KeepInTouch
//
//  Created by ikorobov on 21.02.2023.
//

import SwiftUI

struct StarterView: View {
    @State private var isGrid = false
    var body: some View {
        NavigationView {
            ZStack{
                if isGrid {
                    GridView()
                } else {
                    CarouselView()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        isGrid.toggle()
                    }) {
                        Label("", systemImage: isGrid ? "rectangle.stack" : "circle.grid.2x2" )
                    }
                    Button(action: {
                        isGrid.toggle()
                    }) {
                        Label("", systemImage: "plus" )
                    }
                }
            }
        }

    }
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        StarterView()
    }
}
