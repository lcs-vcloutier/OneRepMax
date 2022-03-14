//
//  Model.swift
//  OneRepMax
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
    Entry(date: Date().addingTimeInterval(84600), exercise: ExercisePossibility.squat, weight: 315),
]
