//
//  ContentView.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-13.
//

import SwiftUI

struct ListView: View {
    @State private var showingAddEntry = false
    var body: some View {
        List(testData) { testData in
            VStack(alignment: .leading) {
                HStack {
                    Text(testData.exercise.rawValue)
                    Spacer()
                    Text("\(testData.weight)LBS")
                }
                .font(.largeTitle)
                Text(testData.date, style: .date)
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
            AddEntryView(showing: $showingAddEntry)
        }
    }
}
