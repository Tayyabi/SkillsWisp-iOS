//
//  NotesViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 08/07/2023.
//

import Foundation
import CoreData
import SwiftUI

class NotesViewModel: ObservableObject {
    
    @Published var savedEntity: NoteModel?
    
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    init() {
        //savedEntity = NotesEntity(context: viewContext)
    }
    
//    func fetchAllNotes(){
//        let fetchRequest: NSFetchRequest<NotesEntity> = NotesEntity.fetchRequest()
//
//        do {
//            let fetchedNotes = try self.viewContext.fetch(fetchRequest)
//
//            savedEntities = fetchedNotes
//            for note in fetchedNotes {
//                let name = note.name
//                //let description = subject.descrip
//            }
//
//        } catch {
//            print("Error fetching users: \(error.localizedDescription)")
//        }
//    }
    
    func populateNote(note: NoteModel) {
        print("populateNote: "+(note.local_url ?? ""))
        savedEntity = note
    }
    func fetchNoteById(id: String) {
        
        
        let fetchRequest: NSFetchRequest<NotesEntity> = NotesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "notes_id == %@", id)
        fetchRequest.sortDescriptors = []
        
        do {
            
            let notes = try viewContext.fetch(fetchRequest)
            
            if notes.isEmpty {
                print("Notes does not exist")
                
            } else {
                print("Notes exists")
                
                if let note = notes.first {
                    savedEntity = NoteModel(notes_id: note.notes_id?.uuidString, name: note.name, chapter: note.chapter, rating: note.rating, local_url: note.local_url, likes_count: note.likes_count, bookmark: note.bookmark, thumbnail: "")
                }
            }
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
            
        }
        
    }
    
    func saveData() {
        
        do {
            try viewContext.save()
            //fetchAllSubjects()
        }
        catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
    func deleteAllEntities() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistenceController.container.persistentStoreCoordinator.execute(deleteRequest, with: viewContext)
            try viewContext.save()
        } catch {
            print("Error deleting entities: \(error.localizedDescription)")
        }
    }
    
}
