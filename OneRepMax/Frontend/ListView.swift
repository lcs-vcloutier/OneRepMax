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
    @State private var showingNewestFirst = true
    @State private var selectedExerciseForVisibleEntries: ExercisePossibility = .all
    var body: some View {
        List(filter(listOfEntries: store.entries, exercise: selectedExerciseForVisibleEntries, showingNewestFirst: showingNewestFirst)) { entry in
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
                Button {
                    showingNewestFirst.toggle()
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            ToolbarItem(placement: .primaryAction) {
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


func filter(listOfEntries: [Entry], exercise: ExercisePossibility, showingNewestFirst: Bool) -> [Entry] {
    
    // Create an empty list of entries
    var filteredEntries: [Entry] = []
    
    // Loop over a list of entries and add the entries that fit the selected exercise to a new list
    for currentEntry in listOfEntries {
        if exercise == . all {
            filteredEntries = listOfEntries
        } else if exercise == .squat && currentEntry.exercise.rawValue == "Squat" {
            filteredEntries.append(currentEntry)
        } else if exercise == .bench && currentEntry.exercise.rawValue == "Bench" {
            filteredEntries.append(currentEntry)
        } else if exercise == .deadlift && currentEntry.exercise.rawValue == "Deadlift" {
            filteredEntries.append(currentEntry)
        }
    }
    
    // Sort the filtered list of entries by comparing the dates of each entry
    if showingNewestFirst == true {
        filteredEntries.sort {
            $0.date > $1.date
        }
    } else {
        filteredEntries.sort {
            $0.date < $1.date
        }
    }
    return filteredEntries
}
