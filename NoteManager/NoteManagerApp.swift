//
//  NoteManagerApp.swift
//  NoteManager
//
//  Created by Dwi Aji Sobarna on 08/04/25.
//

import SwiftUI

@main
struct NoteManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(context: persistenceController.container.viewContext)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

