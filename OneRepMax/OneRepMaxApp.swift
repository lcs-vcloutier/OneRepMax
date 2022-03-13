//
//  OneRepMaxApp.swift
//  OneRepMax
//
//  Created by Vincent Cloutier on 2022-03-13.
//

import SwiftUI

@main
struct OneRepMaxApp: App {
    @StateObject private var store = EntryStore(entries: testData)
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    ListView(store: store)
                }
                .tabItem {
                    Label("List", systemImage: "list.bullet.circle.fill")
                }
                NavigationView {
                   // CalculatorView()
                }
                .tabItem {
                    Label("Calculator", systemImage: "apps.iphone.badge.plus")
                }
            }
        }
    }
}
