//
//  ContentView.swift
//  NoteManager
//
//  Created by Dwi Aji Sobarna on 08/04/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showingAddNote = false
    
    @Environment(\.managedObjectContext) var viewContext

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.dateCreated, order: .reverse)]
    )
    var notes: FetchedResults<Note>

    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NavigationLink(destination: EditNoteView(note: note)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(note.title ?? "Tanpa Judul")
                                .font(.headline)
                            Text(note.content ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(note.dateCreated ?? Date(), style: .date)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                }
                .onDelete(perform: deleteNotes)
            }
            .navigationTitle("Catatan")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddNote = true
                    }) {
                        Label("Tambah", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddNote) {
            AddNoteView()
        }
    }
    
    private func deleteNotes(at offset: IndexSet) {
        for index in offset {
            let note = notes[index]
            viewContext.delete(note)
        }
        
        do {
            try viewContext.save()
        } catch {
            print("❌ Gagal menghapus catatan: \(error.localizedDescription)")
        }
    }
}
