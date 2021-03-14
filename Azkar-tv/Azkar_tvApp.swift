//
//  Azkar_tvApp.swift
//  Azkar-tv
//
//  Created by Mohamed Shemy on Sun 14 Mar 2021.
//

import SwiftUI

@main
struct Azkar_tvApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
