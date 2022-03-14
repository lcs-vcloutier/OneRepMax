//
//  ContentView.swift
//  OneRepMax
//

import SwiftUI

struct ContentView: View {
    // THE DATASTORE'S SOURCE OF TRUTH
    @StateObject private var store = EntryStore(entries: testData)
    // TRACKS WHETHER THE ADD ENTRY VIEW IS SHOWING OR NOT
    @State private var showingAddEntry = false
    // TRACKS USER INPUT FOR THE SELECTED ORDER OF ENTRIES
    @State private var showingNewestFirst = true
    // TRACKS USER INPUT FOR THE SELECTED EXERCISE
    @State private var selectedExercise: ExercisePossibility = .all
    // THE UI THAT SHOWS USERS THEIR ONE REP MAX ENTRIES IN CHRONOLOGICAL ORDER
    var body: some View {
        // ITERATE OVER THE FILTERED LIST OF ENTRIES
        List(filter(listOfEntries: store.entries, exercise: selectedExercise, showingNewestFirst: showingNewestFirst)) { entry in
            // OUTPUT THAT SHOWS THE USER THEIR ENTRIES
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
            // BUTTON THAT SHOWS THE VIEW THAT ALLOWS USERS TO CREATE ENTRIES
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showingAddEntry = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            // BUTTON THAT TOGGLES THE CHRONOLOGICAL ORDER OF THE LIST OF ENTRIES
            ToolbarItem {
                Button {
                    showingNewestFirst.toggle()
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            // PICKER THAT ALLOWS FOR USERS TO FILTER THEIR LIST BY EXERCISE
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Picker("Filter tasks by exercise", selection: $selectedExercise) {
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
        // A SHEET THAT IS REVEALED WHEN SHOWING ADD ENTRY IS TRUE
        // THIS IS WHERE THE ADD ENTRY VIEW IS DISPLAYED
        .sheet(isPresented: $showingAddEntry) {
            AddEntryView(store: store, showing: $showingAddEntry)
        }
    }
}
