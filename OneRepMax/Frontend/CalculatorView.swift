//
//  CalculatorView.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-13.
//

import SwiftUI

struct CalculatorView: View {
    @State private var oneRepMax = ""
    @State private var exercise = ExercisePossibility.squat
    var body: some View {
        Form {
            Section(header: Text("INPUT WEIGHT")) {
                TextField("0", text: $oneRepMax)
                    .keyboardType(.decimalPad)
                    .font(.title)
            }
            Section(header: Text("RESULTS")) {
                Picker("EXERCISE", selection: $exercise) {
                    Text(ExercisePossibility.squat.rawValue).tag(ExercisePossibility.squat)
                    Text(ExercisePossibility.bench.rawValue).tag(ExercisePossibility.bench)
                    Text(ExercisePossibility.deadlift.rawValue).tag(ExercisePossibility.deadlift)
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle("Calculator")
    }
}
