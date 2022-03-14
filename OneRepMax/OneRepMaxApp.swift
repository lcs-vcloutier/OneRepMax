//
//  OneRepMaxApp.swift
//  OneRepMax
//

import SwiftUI

// APP ENTRY POINT
@main
struct OneRepMaxApp: App {
    var body: some Scene {
        WindowGroup {
            // A BOTTOM TAB VIEW THAT ALLOWS USER TO EASILY SWITCH BETWEEN VIEWS
            TabView {
                
                // VIEW THAT ALLOWS USER TO SEE ONE REP MAX ENTRIES AS WELL AS CREATE THEM
                NavigationView { ListView() }
                .tabItem {
                    Label("List", systemImage: "list.bullet.circle.fill")
                }
                
                // VIEW THAT ALLOWS USER TO PREDICT VARIOUS REP MAXES
                NavigationView { CalculatorView() }
                .tabItem {
                    Label("Calculator", systemImage: "apps.iphone.badge.plus")
                }
                
            }
        }
    }
}
