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
    @Binding var showCustomCategoryTF: Bool
    
    var body: some View {
        
        Menu {
            // Попробовать через категори.айконнейм
            ForEach(eventStorage.categories) { category in
                Button(action: {
                    selectedCategory = category
                    showCustomCategoryTF = false
                }) {
                    HStack {
                        Image(systemName: category.categoryIconName(for: category))
                        Text(category.title)
                    }
                }
            }
            Divider()
            Button(action: {
                showCustomCategoryTF.toggle()
            }, label: {
                HStack {
                    Image(systemName: "plus.circle")
                    Text("Other")
                }
            })
            
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
    EventCategoryMenuView(showCustomCategoryTF: .constant(false))
}
