//
//  GibbaApp.swift
//  Gibba
//
//  Created by John Filippone on 10/8/24.
//

import SwiftUI

@main
struct GibbaApp: App {
    @StateObject private var userSettings = UserSettings()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(userSettings)
        }
    }
}
