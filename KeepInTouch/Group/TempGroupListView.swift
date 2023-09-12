//
//  TempGroupListView.swift
//  KeepInTouch
//
//  Created by ikorobov on 09.09.2023.
//

import SwiftUI

struct TempGroupListView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Groups.entity(), sortDescriptors: [NSSortDescriptor(key: "title_", ascending: true)])
    private var groups: FetchedResults<Groups>
    
    @State private var createOperation: CreateOperation<Groups>?
    @State private var showGroupEditView = false
    
    var body: some View {
        ZStack {
            List {
                ForEach(groups) { group in
                    NavigationLink(destination: GroupDetailView(group: group)) {
                        Text("\(group.title)")
                            .foregroundColor(group.colorTheme.accentColor)
                    }
                    .listRowBackground(group.colorTheme.mainColor)
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ButtonView(action: PersistenceController.shared.createMockGroup, imageString: "plus.app.fill", color: .gray)
                        .padding()
                    ButtonView(action: addGroup, imageString: "plus.circle.fill", color: .blue)
                }
                .padding()
            }
        }
        .sheet(item: $createOperation) { createOperation in
            GroupEditView(group: createOperation.childObject, isEdit: false)
                .environment(\.managedObjectContext, createOperation.childContext)
        }
    }
    
    private func addGroup() {
        showGroupEditView = true
        createOperation = CreateOperation(with: viewContext)
    }
}

struct TempGroupListView_Previews: PreviewProvider {
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
        return TempGroupListView()
            .environment(\.managedObjectContext, viewContext)
    }
}
