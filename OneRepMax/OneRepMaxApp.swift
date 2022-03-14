//
//  OneRepMaxApp.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-13.
//

import SwiftUI

@main
struct OneRepMaxApp: App {
    
    // USED TO KEEP TRACK OF IF THE APP IS BACKGROUNDED
    @Environment(\.scenePhase) var scenePhase
    
    // SOURCE OF TRUTH FOR THE APP'S DATASTORE
    @StateObject private var store = EntryStore(entries: testData)
    
    // MAIN UI
    var body: some Scene {
        WindowGroup {
            // A BOTTOM TAB VIEW THAT ALLOWS USER TO EASILY SWITCH BETWEEN VIEWS
            TabView {
                NavigationView {
                    ListView(store: store)
                }
                .tabItem {
                    Label("List", systemImage: "list.bullet.circle.fill")
                }
                NavigationView {
                    CalculatorView()
                }
                .tabItem {
                    Label("Calculator", systemImage: "apps.iphone.badge.plus")
                }
            }
        }
        // IF APP IS BACKGROUNDED, PERSIST ENTRIES IN DATASTORE
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                store.persistEntries()
            }
        }
    }
}
