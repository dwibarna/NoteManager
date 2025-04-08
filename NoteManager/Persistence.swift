//
//  Persistence.swift
//  NoteManager
//
//  Created by Dwi Aji Sobarna on 08/04/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // MARK: - Preview (for SwiftUI preview use)
    @MainActor
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        // Tambahkan dummy data
        for i in 1...5 {
            let note = Note(context: viewContext)
            note.title = "Contoh Catatan \(i)"
            note.content = "Ini adalah isi catatan ke-\(i)"
            note.dateCreated = Date()
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("❌ Gagal menyimpan preview context: \(nsError), \(nsError.userInfo)")
        }

        return controller
    }()

    // MARK: - Persistent Container
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NoteManager") // Pastikan ini sama dengan nama .xcdatamodeld
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("❌ Gagal memuat penyimpanan CoreData: \(error), \(error.userInfo)")
            }
        }

        // Merge otomatis dari background context
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
