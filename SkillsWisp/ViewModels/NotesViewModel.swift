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
    
    
    @Published var likes: [LikeModel] = []
    @Published var bookmarks: [BookmarkModel] = []
    
    let notesDataService = NotesDataService()
    
    
    
    @Published var noteModel: NoteModel?
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    init() {
        //savedEntity = NotesEntity(context: viewContext)
    }
    
    
    
    func addLike(note_id: String, like: Bool) async {
        
        do {
            try await notesDataService.addLikesInDB(note_id: note_id, like: like)
        }
        catch{
            print("Error addLike: \(error)")
        }
        
    }
    func fetchLikes(note_id: String) async {
        
        do {
            try await notesDataService.fetchLikesFromDB(note_id: note_id, completion: { likes in
                
                guard let likes = likes else {
                    return
                }
                self.likes.removeAll()
                self.likes.append(contentsOf: likes)
                
            })
        }
        catch {
            print("Error fetchLikes: \(error)")
        }
        
    }
    
    func updateLikesCount(standard_id: String, subject_id: String, note_id: String, count: Int64) async {
        
        do {
            try await notesDataService.updateLikesCountInDB(standard_id: standard_id,
                                                            subject_id: subject_id,
                                                            note_id: note_id,
                                                            count: count)
        }
        catch {
            print("Error updateLikesCount: \(error)")
        }
    }
    
    
    
    
    
    func addBookmark(note_id: String, bookmark: Bool) async throws {
        
        do {
            try await notesDataService.addBookmarksInDB(note_id: note_id, isBookmark: bookmark)
        }
        catch{
            print("Error addLike: \(error)")
        }
        
    }
    func fetchBookmarks(note_id: String) async {
        
        do {
            try await notesDataService.fetchBookmarksFromDB(note_id: note_id, completion: { bookmarks in
                
                guard let bookmarks = bookmarks else {
                    return
                }
                self.bookmarks.removeAll()
                self.bookmarks.append(contentsOf: bookmarks)
                
            })
        }
        catch {
            print("Error fetchBookmarks: \(error)")
        }
        
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
        noteModel = note
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
                    noteModel = NoteModel(notes_id: note.notes_id?.uuidString, name: note.name, chapter: note.chapter, rating: note.rating, local_url: note.local_url, likes_count: note.likes_count, review_count: 0, bookmark: note.bookmark, thumbnail: "")
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
