//
//  Note.swift
//  NoteManager
//
//  Created by Dwi Aji Sobarna on 08/04/25.
//
import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var dateCreated: Date?
}

extension Note: Identifiable {}
