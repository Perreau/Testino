//
//  Org_CultureApp.swift
//  Org Culture
//
//  Created by Ben Perreau on 3/17/23.
//

import SwiftUI

@main
struct OrgCultureApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
