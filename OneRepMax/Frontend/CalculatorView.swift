//
//  CalculatorView.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-13.
//

import SwiftUI

struct CalculatorView: View {
    
    // TRACKS USER INPUT FOR THE ONE REP MAX WEIGHT
    @State private var oneRepMax = ""
    
    // TRACKS USER INPUT FOR THE SELECTED EXERCISE
    @State private var exercise = ExercisePossibility.squat
    
    // TRACKS PROGRAM OUTPUT FOR THE ABOVE OUTPUTS
    @State private var results = ["0"] // TEMPORARILY STORE A DUMMY VALUE FOR INITIAL UI
    
    // THE USER INTERFACE THAT ALLOWS USERS TO CALCULATE REP MAXES BASED OFF OF THEIR ONE REP MAX
    var body: some View {
        Form {
            
            // INPUT AREA
            Section(header: Text("INPUTS")) {
                
                // WEIGHT INPUT
                TextField("0", text: $oneRepMax)
                    .keyboardType(.decimalPad)
                    .font(.title)
                
                // EXERCISE INPUT
                Picker("EXERCISE", selection: $exercise) {
                    Text(ExercisePossibility.squat.rawValue).tag(ExercisePossibility.squat)
                    Text(ExercisePossibility.bench.rawValue).tag(ExercisePossibility.bench)
                    Text(ExercisePossibility.deadlift.rawValue).tag(ExercisePossibility.deadlift)
                }
                .pickerStyle(.segmented)
                
                // CALCULATE THE RESULTS WHEN PRESSED
                Button {
                    results = calculate(oneRepMax: Double(oneRepMax)!, exercise: exercise)
                } label: {
                    Text("Submit")
                }
                // ONLY ALLOW THIS BUTTON TO BE PRESSED IF THE FORM HAS ACTUALLY BEEN FILLED OUT
                .disabled(oneRepMax.isEmpty)
            }
            
            // OUTPUT AREA
            Section(header: Text("RESULTS")) {
                
                // ITERATE OVER THE LIST OF RESULTS
                List(results.indices, id: \.self) { index in
                    
                    // FOR EACH RESULT SHOW THE USER THE PREDICTED WEIGHT WITH THE CORRESPONDING REP COUNT
                    Text("YOUR \(index + 1) REP MAX IS \(self.results[index]) POUNDS")
                }
            }
        }
        .navigationTitle("Calculator")
    }
}


// CALCULATE PREDICTED MAXIMUM WEIGHTS AT DIFFERENT REP COUNTS BASE ON THE USERS ONE REP MAX AND RETURN A LIST
func calculate(oneRepMax: Double, exercise: ExercisePossibility) -> [String] {
    
    // CREATE AN EMPTY LIST
    var calculation: [String] = []
    
    // ITERATION APPENDS TEN PREDICTED REP MAXES BASED ON THE USER'S SELECTED EXERCISE
    for index in 1...10 {
        if exercise.rawValue == "Squat" {
            calculation.append(String(format:"%.0f", oneRepMax * (pow(0.90, Double(index)))))
        } else if exercise.rawValue == "Bench" {
            calculation.append(String(format:"%.0f", oneRepMax * (pow(0.87, Double(index)))))
        } else {
            calculation.append(String(format:"%.0f", oneRepMax * (pow(0.84, Double(index)))))
        }
    }
    
    // RETURN THE LIST OF PREDICTED REP MAXES
    return calculation
}
