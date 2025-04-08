//
//  AddNoteView.swift
//  NoteManager
//
//  Created by Dwi Aji Sobarna on 08/04/25.
//

import SwiftUI

struct AddNoteView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Judul")) {
                    TextField("Masukan judul", text: $title)
                }
                
                    Section(header: Text("Isi")) {
                        TextEditor(text: $content)
                            .frame(height: 150)

                    }
            }
            .navigationTitle("Nambah Catatan")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Simpan") {
                        let newNote = Note(context: viewContext)
                        newNote.title = title
                        newNote.content = content
                        newNote.dateCreated = Date()
                        
                        do {
                            try viewContext.save()
                            dismiss()
                        } catch {
                            print("❌ Gagal menyimpan: \(error.localizedDescription)")
                        }
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Batal") {
                        dismiss()
                    }
                }
            }
        }
    }
}
