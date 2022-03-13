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
    @State private var results = ["0"]
    @State private var tracker = 0
    
    var body: some View {
        Form {
            Section(header: Text("INPUTS")) {
                TextField("0", text: $oneRepMax)
                    .keyboardType(.decimalPad)
                    .font(.title)
                Picker("EXERCISE", selection: $exercise) {
                    Text(ExercisePossibility.squat.rawValue).tag(ExercisePossibility.squat)
                    Text(ExercisePossibility.bench.rawValue).tag(ExercisePossibility.bench)
                    Text(ExercisePossibility.deadlift.rawValue).tag(ExercisePossibility.deadlift)
                }
                .pickerStyle(.segmented)
                Button {
                    results = calculate(oneRepMax: Double(oneRepMax)!, exercise: exercise)
                } label: {
                    Text("Submit")
                }
                .disabled(oneRepMax.isEmpty)
            }
            Section(header: Text("RESULTS")) {
                List(results.indices, id: \.self) { index in
                    Text("YOUR \(index + 1) REP MAX IS \(self.results[index]) POUNDS")
                }
            }
        }
        .navigationTitle("Calculator")
    }
}

func calculate(oneRepMax: Double, exercise: ExercisePossibility) -> [String] {
    var calculation = [""]
    for index in 1...10 {
        if exercise.rawValue == "Squat" {
            calculation.append(String(format:"%.0f", oneRepMax * (pow(0.90, Double(index)))))
            
        } else if exercise.rawValue == "Bench" {
            calculation.append(String(format:"%.0f", oneRepMax * (pow(0.87, Double(index)))))
        } else {
            calculation.append(String(format:"%.0f", oneRepMax * (pow(0.84, Double(index)))))
        }
    }
    calculation.removeFirst()
    return calculation
}
