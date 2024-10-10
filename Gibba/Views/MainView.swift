//
//  MainView.swift
//  Gibba
//
//  Created by John Filippone on 10/8/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NewJobView()
                .tabItem {
                    Label("New Job", systemImage: "plus")
                }
            JobsView()
                .tabItem {
                    Label("Jobs", systemImage: "list.bullet")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

// Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserSettings())
    }
}
