//
//  UserSettings.swift
//  Gibba
//
//  Created by John Filippone on 10/8/24.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var name: String {
        didSet {
            UserDefaults.standard.set(name, forKey: "userName")
        }
    }
    
    init() {
        self.name = UserDefaults.standard.string(forKey: "userName") ?? ""
    }
}
