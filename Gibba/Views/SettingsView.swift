//
//  SettingsView.swift
//  Gibba
//
//  Created by John Filippone on 10/8/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        Form {
            TextField("Enter your name", text: $userSettings.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .navigationTitle("Settings")
    }
}

// Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserSettings())
    }
}
