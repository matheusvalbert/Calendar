//
//  CalendarApp.swift
//  Calendar
//
//  Created by Matheus Valbert on 10/01/21.
//

import SwiftUI

@main
struct CalendarApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
