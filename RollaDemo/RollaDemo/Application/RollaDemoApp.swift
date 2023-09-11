//
//  RollaDemoApp.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 10. 9. 2023..
//

import SwiftUI

@main
struct RollaDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
