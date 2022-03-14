//
//  Model.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-13.
//

import Foundation

// ALL THE POSSIBLE EXERCISES
enum ExercisePossibility: String, Codable {
    case all = "All"
    case squat = "Squat"
    case bench = "Bench"
    case deadlift = "Deadlift"
}

// TRACKS A SINGLE ENTRY
struct Entry: Identifiable, Codable {
    
    // STORED PROPERTIES
    var id = UUID()
    var date: Date
    var exercise: ExercisePossibility
    var weight: Int
    
}

let testData = [
    Entry(date: Date(), exercise: ExercisePossibility.bench, weight: 225),
    Entry(date: Date(), exercise: ExercisePossibility.squat, weight: 315),
    Entry(date: Date(), exercise: ExercisePossibility.deadlift, weight: 405)
]
