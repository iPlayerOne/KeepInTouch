//
//  PersonListView.swift
//  KeepInTouch
//
//  Created by ikorobov on 23.02.2023.
//

import SwiftUI

struct PersonListView: View {
    @State private var groups = Sample.sampleGroups
    
    var body: some View {
        VStack {
            GroupIconView(title: groups[0].title , theme: ColorTheme(rawValue: (groups[0].colorTheme).rawValue) ?? ColorTheme.magenta)
                .frame(maxHeight: 250)
                .padding()
            EventFooterView()
                .padding()
            ScrollView {
                LazyVStack {
                    ForEach(groups[0].persons) { person in
                        PersonCellView(
                            title: "\(person.firstName.first ?? "I")" + "\(person.lastName.first ?? "K")",
                            name: person.fullName,
                            theme: ColorTheme.indigo)
                        Divider()
                    }
                }
                .padding()
            }
            .padding(.top)
        }
        .background(Color.mint)
        .navigationBarTitle("Friends")
    }
}

struct PersonListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonListView()
    }
}
