//
//  Pocket_TrackerApp.swift
//  Pocket Tracker
//
//  Created by Yinan An on 1/3/22.
//

import SwiftUI

@main
struct Pocket_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
