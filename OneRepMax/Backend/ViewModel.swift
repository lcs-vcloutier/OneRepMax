//
//  ViewModel.swift
//  OneRepMax
//

import Foundation

// RETURNS THE CORRECT LOCATIION TO STORE/RETRIEVE ENTRIES
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

// RETRIEVES AND STORES THE LIST OF ENTRIES
class EntryStore: ObservableObject {
    // TRACKS A LIST OF ENTRIES
    @Published var entries: [Entry]
    // RETRIEVES THE ENTRIES LIST
    init(entries: [Entry] = []) {
        let filename = getDocumentsDirectory().appendingPathComponent("savedEntries")
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
        let filename = getDocumentsDirectory().appendingPathComponent("savedEntries")
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
