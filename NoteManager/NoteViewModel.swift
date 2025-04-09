//
//  NoteViewModel.swift
//  NoteManager
//
//  Created by Dwi Aji Sobarna on 08/04/25.
//

import Foundation
import CoreData

class NoteViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    private func fetchNotes() {
        let request = NSFetchRequest<Note>(entityName: "note")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Note.dateCreated, ascending: false)]
        
        do {
            notes = try context.fetch(request)
        } catch {
            print("❌ Gagal fetch: \(error.localizedDescription)")
        }
    }
    
    func addNote(title: String, content: String) {
        let newNote = Note(context: context)
        newNote.title = title
        newNote.content = content
        newNote.dateCreated = Date()
        
        save()
    }
    
    func deleteNote(_ note: Note) {
        context.delete(note)
        save()
    }
    
    private func save() {
        do {
            try context.save()
            fetchNotes()
        } catch {
            print("❌ Gagal tambah note: \(error.localizedDescription)")
        }
    }
}
