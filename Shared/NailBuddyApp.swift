//
//  NailBuddyApp.swift
//  Shared
//
//  Created by Mike the Great on 6/11/21.
//

import SwiftUI

@main
struct NailBuddyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
