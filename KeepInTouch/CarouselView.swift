//
//  CarouselView.swift
//  KeepInTouch
//
//  Created by ikorobov on 21.02.2023.
//

import SwiftUI

struct CarouselView: View {
    @State private var groups = Sample.sampleGroups
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State private var isActive = false
    
    
    var body: some View {
        VStack {
            Spacer()
            NavigationLink(destination: PersonListView(), isActive: $isActive) {
                EmptyView()
            }
            ZStack {
                ForEach(Array(groups.enumerated()), id: \.offset) { index, group in
                    ZStack {
                        GroupIconView(title: group.title, theme: group.colorTheme)
                            .frame(width: 300, height: 300)
                            .scaleEffect(1.0 - abs(distance(index)) * 0.2)
                            .opacity(1.0 - abs(distance(index)) * 0.3)
                            .offset(x: xOffset(index), y: yOffset(index))
                            .zIndex(1.0 - abs(distance(index)) * 0.1 )
                            .onTapGesture {
                                isActive = true
                            }
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { drag in
                            draggingItem = snappedItem + drag.translation.width / 100
                        }
                        .onEnded{ drag in
                            withAnimation {
                                draggingItem = snappedItem + drag.predictedEndTranslation.width / 100
                                draggingItem = round(draggingItem).remainder(dividingBy: Double(groups.count))
                                snappedItem = draggingItem
                            }
                        }
                )
            }
            Spacer()
            EventFooterView()
                .padding()
        }
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(groups.count))
    }
    
    func angle(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(groups.count) * distance(item)
        return angle * 180 / Double.pi
    }
    
    func xOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(groups.count) * distance(item)
        return sin(angle) * 200
    }
    
    func yOffset(_ item: Int) -> CGFloat {
        let angle = CGFloat(distance(item)) * .pi * 2 / CGFloat(groups.count)
        let yMultiplier = sin(angle) * 0.3
        return -yMultiplier * 0
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
