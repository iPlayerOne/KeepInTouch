
//  PersonDetailView.swift
//  KeepInTouch
//
//  Created by ikorobov on 24.02.2023.


import SwiftUI

struct PersonDetailView: View {
    @State var person: Person
    
    var body: some View {
        NavigationView {
            VStack {

                Divider()
                Text("Birthday: \(person.dateFormatter.string(from: person.birthday))")
                    .padding()
                Divider()
                Text("Meetings:")
                    .padding()
                ForEach(person.meetings) { meeting in
                    Text("\(person.dateFormatter.string(from: meeting.date))")
                        .padding(.leading)
                }
                Divider()
                Text("Events:")
                    .padding()
                ForEach(person.events) { event in
                    Text("\(event.title) - \(person.dateFormatter.string(from: event.date))")
                        .padding(.leading)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("\(person.fullName)")
            .toolbar {
                Button(action: {
                    
                }) {
                    Image(systemName: "pencil")
                }
            }
        }
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: Sample.sampleData[0])
    }
}
