//
//  ViewModel.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-13.
//

import Foundation

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

class EntryStore: ObservableObject {
    
    // Stored propeties
    @Published var entries: [Entry]
    
    // Initializers
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
    
    // Save entry to entries array.
    func saveEntry(date: Date, exercise: ExercisePossibility, weight: Int) {
        entries.append(Entry(date: date, exercise: exercise, weight: weight))
    }
    
    // Persist entire entries array.
    func persistEntries() {
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
