//
//  ContentView.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-13.
//

import SwiftUI

struct ListView: View {
    
    // CONNECT TO THE DATASTORE'S SOURCE OF TRUTH
    @ObservedObject var store: EntryStore
    
    // TRACKS WHETHER THE ADD ENTRY VIEW IS SHOWING OR NOT
    @State private var showingAddEntry = false
    
    // TRACKS USER INPUT FOR THE SELECTED ORDER OF ENTRIES
    @State private var showingNewestFirst = true
    
    // TRACKS USER INPUT FOR THE SELECTED EXERCISE
    @State private var selectedExerciseForVisibleEntries: ExercisePossibility = .all
    
    // THE USER INTERFACE THAT SHOWS USERS THEIR ONE REP MAX ENTRIES IN CHRONOLOGICAL ORDER
    var body: some View {
        
        // ITERATE OVER THE FILTERED LIST OF ENTRIES
        List(filter(listOfEntries: store.entries, exercise: selectedExerciseForVisibleEntries, showingNewestFirst: showingNewestFirst)) { entry in
            
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
        // A SHEET THAT IS REVEALED WHEN SHOWING ADD ENTRY IS TRUE
        // THIS IS WHERE THE ADD ENTRY VIEW IS DISPLAYED
        .sheet(isPresented: $showingAddEntry) {
            AddEntryView(store: store, showing: $showingAddEntry)
        }
    }
}

// FILTER A LIST OF ENTRIES BY BOTH DATE AND EXERCISE POSSIBILITY THEN RETURN THE FILTERED LIST
func filter(listOfEntries: [Entry], exercise: ExercisePossibility, showingNewestFirst: Bool) -> [Entry] {
    
    // CREATE AN EMPTY LIST
    var filteredEntries: [Entry] = []
    
    // ITERATE OVER THE INITIAL LIST OF ENTRIES
    // ADD THOSE THAT FIT THE SELECTED EXERCISE TO THE FILTERED LIST
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
    
    // SORT THE FILTERED LIST OF ENTRIES BY COMPARING THE DATES OF EACH ENTRY
    // THIS IS DEPENDENT ON WHAT TYPE OF CHRONOLOGICAL ORDER THE USER SELECTED
    if showingNewestFirst == true {
        filteredEntries.sort {
            $0.date > $1.date
        }
    } else {
        filteredEntries.sort {
            $0.date < $1.date
        }
    }
    
    // RETURN THE LIST OF FILTERED ENTRIES
    return filteredEntries
}
