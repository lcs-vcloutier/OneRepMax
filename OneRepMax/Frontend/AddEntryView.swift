//
//  AddEntryView.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-13.
//

import SwiftUI

struct AddEntryView: View {
    
    // CONNECT TO THE DATASTORE'S SOURCE OF TRUTH
    @ObservedObject var store: EntryStore
    
    // TRACKS WHETHER THIS VIEW IS SHOWING OR NOT
    @Binding var showing: Bool
    
    // TRACKS USER INPUT FOR THE SELECTED DATE
    @State private var date = Date()
    
    // TRACKS USER INPUT FOR THE SELECTED EXERCISE
    @State private var exercise = ExercisePossibility.squat
    
    // TRACKS USER INPUT FOR THE SELECTED WEIGHT
    @State private var weight = ""
    
    
    // THE USER INTERFACE THAT ALLOWS USERS TO CREATE ONE REP MAX ENTRIES
    var body: some View {
        NavigationView {
            
            // INPUT AREA
            Form {
                
                // WEIGHT INPUT
                Section(header: Text("Weight")) {
                    TextField("225", text: $weight)
                        .keyboardType(.decimalPad)
                        .font(.title)
                }
                
                // EXERCISE INPUT
                Section(header: Text("Exercise")) {
                    Picker("EXERCISE", selection: $exercise) {
                        Text(ExercisePossibility.squat.rawValue).tag(ExercisePossibility.squat)
                        Text(ExercisePossibility.bench.rawValue).tag(ExercisePossibility.bench)
                        Text(ExercisePossibility.deadlift.rawValue).tag(ExercisePossibility.deadlift)
                    }
                    .pickerStyle(.segmented)
                }
                
                // DATE INPUT
                Section(header: Text("Date")) {
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }
            }
            .navigationTitle(exercise.rawValue)
            .toolbar {
                
                // BUTTON THAT SAVES THE CURRENT ENTRY AND HIDES THIS VIEW
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        store.saveEntry(date: date, exercise: exercise, weight: Int(weight)!)
                        showing = false
                    }
                    
                    // ONLY ALLOW THIS BUTTON TO BE PRESSED IF THE FORM HAS ACTUALLY BEEN FILLED OUT
                    .disabled(weight.isEmpty)
                    
                }
                
                // BUTTON THAT HIDES THIS VIEW
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showing = false
                    }
                }
            }
        }
        // DISABLE SWIPE TO DISMISS
        .interactiveDismissDisabled()
    }
}

