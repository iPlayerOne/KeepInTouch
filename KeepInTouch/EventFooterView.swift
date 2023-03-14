//
//  EventFooterView.swift
//  KeepInTouch
//
//  Created by ikorobov on 23.02.2023.
//

import SwiftUI

struct EventFooterView: View {
    var body: some View {
        
//        HStack {
//            Label("Some name", image: "person")
//            Spacer()
//            Label("Some Event", image: "person")
//        }
//        .padding(8)
//        .overlay {
//            RoundedRectangle(cornerRadius: 10)
//
//                .stroke(Color.secondary, lineWidth: 1)
//                .opacity(0.8)
//        }
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.secondary)
                .shadow(radius: 10, x: 10, y: 10)
                .frame(height: 100)
                .background(Color.clear)
            .opacity(0.4)
            .overlay {
                HStack {
                    Label("Some name", image: "person")
                    Spacer()
                    Label("Some date", image: "date")
                }
        
            }
        }
    }
}

struct EventFooterView_Previews: PreviewProvider {
    static var previews: some View {
        EventFooterView()
    }
}
