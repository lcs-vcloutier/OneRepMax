//
//  FilterFunction.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-14.
//

import Foundation

// FILTER A LIST OF ENTRIES BY BOTH DATE AND EXERCISE POSSIBILITY THEN RETURN THE FILTERED LIST
func filter(listOfEntries: [Entry], exercise: ExercisePossibility, showingNewestFirst: Bool) -> [Entry] {
    // CREATE AN EMPTY LIST
    var filteredEntries: [Entry] = []
    // ITERATE OVER THE INITIAL LIST OF ENTRIES
    // ADD THOSE THAT FIT THE SELECTED EXERCISE TO THE FILTERED LIST
    for currentEntry in listOfEntries {
        if exercise == . all {
            filteredEntries = listOfEntries
        } else if exercise == .squat && currentEntry.exercise.rawValue == "Squat" {
            filteredEntries.append(currentEntry)
        } else if exercise == .bench && currentEntry.exercise.rawValue == "Bench" {
            filteredEntries.append(currentEntry)
        } else if exercise == .deadlift && currentEntry.exercise.rawValue == "Deadlift" {
            filteredEntries.append(currentEntry)
        }
    }
    // SORT THE FILTERED LIST OF ENTRIES BY COMPARING THE DATES OF EACH ENTRY
    // THIS IS DEPENDENT ON WHAT TYPE OF CHRONOLOGICAL ORDER THE USER SELECTED
    if showingNewestFirst == true {
        filteredEntries.sort {
            $0.date > $1.date
        }
    } else {
        filteredEntries.sort {
            $0.date < $1.date
        }
    }
    // RETURN THE LIST OF FILTERED ENTRIES
    return filteredEntries
}
