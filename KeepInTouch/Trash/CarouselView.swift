//
//  CarouselView.swift
//  KeepInTouch
//
//  Created by ikorobov on 21.02.2023.
//

import SwiftUI

struct CarouselView: View {
    
    @State private var selectedGroup: Groups?
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State private var isActive = false
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Groups.entity(), sortDescriptors: [NSSortDescriptor(key: "title_", ascending: true)])
    private var groups: FetchedResults<Groups>
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ZStack {
                    ForEach(groups.indices, id: \.self) { index in
                        NavigationLink(destination: GroupEditView(group: groups[index], isEdit: true)) {
                            ZStack {
                                GroupIconView(title: groups[index].title , theme: groups[index].colorTheme)
                                    .frame(width: 250, height: 250)
                                    .scaleEffect(1.0 - abs(distance(index)) * 0.2)
                                    .opacity(1.0 - abs(distance(index)) * 0.2)
                                    .offset(x: xOffset(index), y: 0)
                                    .zIndex(1.0 - abs(distance(index)) * 0.1 )
                                    .onTapGesture {
                                        isActive = true
                                        selectedGroup = groups[index]
                                    }
                            }
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { drag in
                                draggingItem = snappedItem + drag.translation.width / 100
                            }
                            .onEnded { drag in
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
    
//    func yOffset(_ item: Int) -> CGFloat {
//        let angle = CGFloat(distance(item)) * Double.pi * 2 / CGFloat(groups)
//        let yMultiplier = sin(angle) * 0.3
//        return CGFloat(-yMultiplier * 0)
//    }
}

struct CarouselView_Previews: PreviewProvider {
    
    static var previews: some View {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.viewContext
        for i in 0..<6 {
            let newGroup = Groups(context: viewContext)
            newGroup.id = UUID()
            newGroup.title = "Group \(i)"
            newGroup.theme = Int16(i)
        }
        viewContext.saveContext()
        return CarouselView().environment(\.managedObjectContext, viewContext)

    }
}
