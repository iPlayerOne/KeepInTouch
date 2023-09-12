//
//  GridView.swift
//  KeepInTouch
//
//  Created by ikorobov on 21.02.2023.
//

import SwiftUI

struct GridView: View {
    @State private var isShowingGroupEditView = false
    
    @Environment(\.managedObjectContext)  private var viewContext
    @FetchRequest(entity: Groups.entity(), sortDescriptors: [NSSortDescriptor(key: "title_", ascending: true)])
    private var groups: FetchedResults<Groups>
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                    ForEach(groups) { group in
                        NavigationLink(destination: GroupEditView(group: group, isEdit: true)) {
                            GroupIconView(title: group.title , theme: group.colorTheme)
                                .scaledToFit()

                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 0)
            }
    }
        
}

struct GridView_Previews: PreviewProvider {
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
        return GridView().environment(\.managedObjectContext, viewContext)
    }
}
