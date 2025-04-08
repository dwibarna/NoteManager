//
//  EditNoteView.swift
//  NoteManager
//
//  Created by Dwi Aji Sobarna on 08/04/25.
//

import SwiftUI

struct EditNoteView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var note: Note
    
    var body: some View {
        Form {
            Section(header: Text("Judul")) {
                TextField("Masukan Judul", text: Binding(get: {note.title ?? ""}, set: {note.title = $0}))
                }
            Section(header: Text("Isi")) {
                TextEditor(text: Binding(get: {note.content ?? ""}, set: {note.content = $0}))
                    .frame(height: 150)
            }
            
            Section {
                Button(role: .destructive) {
                    viewContext.delete(note)
                    
                    do {
                        try viewContext.save()
                        dismiss()
                    } catch {
                        print("❌ Gagal menghapus catatan: \(error.localizedDescription)")
                    }
                    
                } label: {
                    Label("Hapus Catatan", systemImage: "trash")
                }
            }
        }
        .navigationTitle("Edit Catatan")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Simpan") {
                    note.dateCreated = Date()
                    
                    do {
                        try viewContext.save()
                        dismiss()
                    } catch {
                        print("❌ Gagal menyimpan: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
