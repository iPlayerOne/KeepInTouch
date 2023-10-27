//
//  NotificationSegmentPickerView.swift
//  KeepInTouch
//
//  Created by ikorobov on 14.10.2023.
//

import SwiftUI

struct NotificationSegmentPickerView: View {
    
    @State private var frenquency: NotificationFrequency = .onceADay
    
    var body: some View {
        Picker(selection: $frenquency, label: Text("Notification level")) {
            ForEach(NotificationFrequency.allCases, id: \.self) { frenquency in
                Text(frenquency.rawValue).tag(frenquency)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

#Preview {
    NotificationSegmentPickerView()
}
