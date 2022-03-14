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

// STORES AND RETRIEVES ENTRIES
class EntryStore: ObservableObject {
    
    // STORED PROPERTIES
    @Published var entries: [Entry]
    
    // INITIALIZER
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
    
    // SAVES AN ENTRY INTO THE ENTRIES ARRAY, THEN PERSISTS THE ARRAY
    func saveEntry(date: Date, exercise: ExercisePossibility, weight: Int) {
        
        // ADDS THE SINGLE ENTRY TO THE END OF THE ARRAY
        entries.append(Entry(date: date, exercise: exercise, weight: weight))
        
        // PERSISTS THE ARRAY OF ENTRIES
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
