//
//  GroupAddView.swift
//  KeepInTouch
//
//  Created by ikorobov on 31.08.2023.
//

import SwiftUI
// Bridge to GroupEditView. Making new GroupEntity
struct GroupAddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    //State of new entity
    @State private var newGroup: Groups? = nil
    
    var body: some View {
        //Use group because swift won't let us
        Group {
            if let group = newGroup {
                GroupEditView(group: group, isEdit: false)
            } else {
                ProgressView()
                    .onAppear {
                        newGroup = Groups(context: viewContext)
                    }
            }
        }
        .navigationBarHidden(true)
    }
}

struct GroupAddView_Previews: PreviewProvider {
    static var previews: some View {
        GroupAddView()
    }
}
