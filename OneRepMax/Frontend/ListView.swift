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
    @State private var selectedExerciseForVisibleEntries: ExercisePossibility = .all
    var body: some View {
        List(filter(store.entries, by: selectedExerciseForVisibleEntries)) { entry in
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
        .navigationTitle("Tracker")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showingAddEntry = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem {
                Menu {
                    Picker("Filter tasks by exercise", selection: $selectedExerciseForVisibleEntries) {
                        Text(ExercisePossibility.all.rawValue).tag(ExercisePossibility.all)
                        Text(ExercisePossibility.squat.rawValue).tag(ExercisePossibility.squat)
                        Text(ExercisePossibility.bench.rawValue).tag(ExercisePossibility.bench)
                        Text(ExercisePossibility.deadlift.rawValue).tag(ExercisePossibility.deadlift)
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.circle")
                }
            }
        }
        .sheet(isPresented: $showingAddEntry) {
            AddEntryView(store: store, showing: $showingAddEntry)
        }
    }
}


func filter(_ listOfEntries: [Entry], by exercise: ExercisePossibility) -> [Entry] {

        // When the user wants to see all entries, just return the list provided
        if exercise == .all {
            return listOfEntries
        } else {
            // Create an empty list of entries
            var filteredEntries: [Entry] = []

            // Iterate over the list of entries, and build a new list w selected type of entry
            for currentEntry in listOfEntries {
                if exercise == .squat && currentEntry.exercise.rawValue == "Squat" {
                    filteredEntries.insert(currentEntry, at: 0)
                } else if exercise == .bench && currentEntry.exercise.rawValue == "Bench" {
                    filteredEntries.insert(currentEntry, at: 0)
                } else if exercise == .deadlift && currentEntry.exercise.rawValue == "Deadlift" {
                    filteredEntries.insert(currentEntry, at: 0)
                    }
            }
            // Return the filtered list of entries
            return filteredEntries
        }
}
