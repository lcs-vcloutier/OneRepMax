//
//  Backend.swift
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

// RETRIEVES AND STORES THE LIST OF ENTRIES
class EntryStore: ObservableObject {
    // A LIST OF ENTRIES
    @Published var entries: [Entry]
    // THE LOCATION TO STORE THE LIST OF ENTRIES
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // RETRIEVES THE ENTRIES LIST
    init(entries: [Entry] = []) {
        let filename = paths[0].appendingPathComponent("savedEntries")
        do {
            let data = try Data(contentsOf: filename)
            self.entries = try JSONDecoder().decode([Entry].self, from: data)
        } catch {
            print(error.localizedDescription)
            self.entries = entries
        }
    }
    // SAVES AN ENTRY INTO THE ENTRIES LIST, THEN PERSISTS THE LIST
    func saveEntry(date: Date, exercise: ExercisePossibility, weight: Int) {
        entries.append(Entry(date: date, exercise: exercise, weight: weight))
        let filename = paths[0].appendingPathComponent("savedEntries")
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self.entries)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
}

let testData = [
    Entry(date: Date(), exercise: ExercisePossibility.bench, weight: 225),
    Entry(date: Date().addingTimeInterval(84600), exercise: ExercisePossibility.squat, weight: 315),
]
