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
    @State private var results = [0]
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
                    results = calculate(oneRepMax: Int(oneRepMax)!, exercise: exercise)
                } label: {
                    Text("Submit")
                }
                .disabled(oneRepMax.isEmpty)
            }
            Section(header: Text("RESULTS")) {
                List(results.indices, id: \.self) { index in
                    Text("\(index + 1)RM = \(self.results[index])LBS")
                }
            }
        }
        .navigationTitle("Calculator")
    }
}

func calculate(oneRepMax: Int, exercise: ExercisePossibility) -> [Int] {
    var calculation = [0]
    for index in 1...10 {
        if exercise.rawValue == "Squat" {
            calculation.append(oneRepMax*index)
        } else if exercise.rawValue == "Bench" {
            calculation.append(oneRepMax/index)
        } else {
            calculation.append(oneRepMax+index)
        }
    }
    calculation.removeFirst()
    return calculation
}
