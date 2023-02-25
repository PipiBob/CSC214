//
//  MindersApp.swift
//  Minders
//
//  Created by Arthur Roolfs on 11/14/22.
//

import SwiftUI

@main
struct MindersApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    var itemsVM: JokeVM
    init() {
        itemsVM = JokeVM(jokes: FileManager.default.getItems())
    }
    
    // MARK: - Body
    
    var body: some Scene {
        //WindowGroup { Content1View()}
    
        WindowGroup {
            ContentView()
                .environmentObject(itemsVM)
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active {
                print("Active")
            } else if newPhase == .background {
                print("Background")
                FileManager.default.saveItems(jokes: itemsVM.jokes)
            }
        }
    }
}
