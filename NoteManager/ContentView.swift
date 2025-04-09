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
    @StateObject private var noteViewModel: NoteViewModel
    
    @Environment(\.managedObjectContext) var viewContext

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.dateCreated, order: .reverse)]
    )
    var notes: FetchedResults<Note>

    init(context: NSManagedObjectContext) {
        _noteViewModel = StateObject(wrappedValue: NoteViewModel(context: context))
    }
    
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
                .onDelete { indexSet in
                    indexSet.forEach { offset in
                        let note = notes[offset]
                        noteViewModel.deleteNote(note)
                    }
                    
                }
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
}

#Preview {
    ContentView(context: PersistenceController.preview.container.viewContext)
}

