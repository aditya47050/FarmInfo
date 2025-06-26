//
//  FarmInfoApp.swift
//  FarmInfo
//
//  Created by Aditya on 25/06/25.
//

import SwiftUI

@main
struct FarmInfoApp: App {
    var body: some Scene {
        WindowGroup {
            VegetableTabBarScreen()
                .modelContainer(for: [Vegetable.self, MyGardenVegetable.self, Note.self])
                .environmentObject(LanguageManager.shared)
        }
    }
}
