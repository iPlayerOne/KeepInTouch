//
//  EventCategoryPickerView.swift
//  KeepInTouch
//
//  Created by ikorobov on 12.10.2023.
//

import SwiftUI

struct EventCategoryMenuView: View {
    @ObservedObject var eventStorage = EventCategoryStorage()
    @State private var selectedCategory: EventCategory?
    var body: some View {
        
        Menu {
            ForEach(eventStorage.categories) { category in
                Button(action: {
                    selectedCategory = category
                }) {
                    HStack {
                        Image(systemName: category.categoryIconName(for: category))
                        Text(category.title)
                    }
                }
            }
        } label: {
            HStack {
                if let selected = selectedCategory {
                    Image(systemName: selected.categoryIconName(for: selected))
                    Text(selected.title)
                }
                Text("Choose category")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
        }
    }
}

#Preview {
    EventCategoryMenuView()
}
