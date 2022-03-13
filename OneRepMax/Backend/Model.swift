//
//  Model.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-13.
//

import Foundation

enum ExercisePossibility: String, Codable {
    case squat = "Squat"
    case bench = "Bench"
    case deadlift = "Deadlift"
}

struct Entry: Identifiable {
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
