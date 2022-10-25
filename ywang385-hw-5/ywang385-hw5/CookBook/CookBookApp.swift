//
//  CookBookApp.swift
//  CookBook
//
//  Created by pipiBob on 10/24/22.
//

import SwiftUI

@main
struct CookBookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
