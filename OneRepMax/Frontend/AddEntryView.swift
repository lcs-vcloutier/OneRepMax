//
//  AddEntryView.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-13.
//

import SwiftUI

struct AddEntryView: View {
    @ObservedObject var store: EntryStore
    @Binding var showing: Bool
    @State private var date = Date()
    @State private var exercise = ExercisePossibility.squat
    @State private var weight = ""
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Weight")) {
                    TextField("225", text: $weight)
                        .keyboardType(.decimalPad)
                        .font(.title)
                }
                Section(header: Text("Exercise")) {
                    Picker("EXERCISE", selection: $exercise) {
                        Text(ExercisePossibility.squat.rawValue).tag(ExercisePossibility.squat)
                        Text(ExercisePossibility.bench.rawValue).tag(ExercisePossibility.bench)
                        Text(ExercisePossibility.deadlift.rawValue).tag(ExercisePossibility.deadlift)
                    }
                    .pickerStyle(.segmented)
                }
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
            .navigationTitle(exercise.rawValue)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        store.saveEntry(date: date, exercise: exercise, weight: Int(weight)!)
                        showing = false
                    }
                    .disabled(weight.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showing = false
                    }
                }
            }
        }
        .interactiveDismissDisabled()
    }
}

