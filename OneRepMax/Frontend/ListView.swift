//
//  ContentView.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-13.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var store: EntryStore
    @State private var showingAddEntry = false
    var body: some View {
        List(store.entries) { entry in
            VStack(alignment: .leading) {
                HStack {
                    Text(entry.exercise.rawValue)
                    Spacer()
                    Text("\(entry.weight)LBS")
                }
                .font(.largeTitle)
                Text(entry.date, style: .date)
                    .font(.caption)
            }
        }
        .navigationTitle("One Rep Max")
        .toolbar {
            ToolbarItem {
                Button {
                    showingAddEntry = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddEntry) {
            AddEntryView(store: store, showing: $showingAddEntry)
        }
    }
}
