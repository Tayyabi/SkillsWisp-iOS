//
//  SubjectViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 08/07/2023.
//

import Foundation
import CoreData
import SwiftUI

class SubjectViewModel: ObservableObject {
    
    @Published var savedEntities: [NoteModel] = []
    
    let homeDataService = HomeDataService()
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    init() {
        //deleteAllEntities()
        //fetchAllSubjects()
    }
    
    func fetchNotesFromDB(standard_id: String, subject_id: String) async {
        try? await homeDataService.fetchNotesFromDB(standard_id: standard_id, subject_id: subject_id) { notes in
            guard let notes = notes else {
                return
            }
            self.savedEntities = notes
        }
    }
    
    func fetchAllNotes(){
        let fetchRequest: NSFetchRequest<NotesEntity> = NotesEntity.fetchRequest()
        
        do {
            let fetchedNotes = try self.viewContext.fetch(fetchRequest)
            
            //savedEntities = fetchedNotes
            for note in fetchedNotes {
                savedEntities.append(NoteModel(notes_id: note.notes_id?.uuidString, name: note.name, chapter: note.chapter, rating: note.rating, local_url: note.local_url, likes_count: note.likes_count, bookmark: note.bookmark, thumbnail: ""))
            }
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
    }
    
    func fetchNotesById(id: String) {
        
        
        let fetchRequest: NSFetchRequest<SubjectEntity> = SubjectEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "notes_id.@count > 0 ", id)
        fetchRequest.sortDescriptors = []
        
        do {
            
            let subjects = try viewContext.fetch(fetchRequest)
            
            if subjects.isEmpty {
                print("Notes does not exist")
                
            } else {
                print("Notes exists")
                
                if let subjects = subjects.first {
                    if let notes = subjects.notes_id as? Set<NotesEntity> {
                        //savedEntities = Array(notes)
                        for note in notes {
                            savedEntities.append(NoteModel(notes_id: note.notes_id?.uuidString, name: note.name, chapter: note.chapter, rating: note.rating, local_url: note.local_url, likes_count: note.likes_count, bookmark: note.bookmark, thumbnail: ""))
                        }
                    }
                }
            }
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
            
        }
        
    }
    
//    func updateEntity(id: UUID){
//        let fetchRequest: NSFetchRequest<StandardEntity> = StandardEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "standard_id == %@", id.uuidString)
//        fetchRequest.sortDescriptors = []
//
//        do {
//
//            let standards = try viewContext.fetch(fetchRequest)
//
//            if standards.isEmpty {
//                print("Email does not exist")
//
//            } else {
//                print("Email exists")
//
//                if let standard = standards.first {
//                    if let subjects = standard.subject_id as? Set<SubjectEntity> {
//
//                        let note0 = NotesEntity(context: viewContext)
//                        note0.name = "9th Class Physics"
//                        note0.chapter = "All Chapters"
//                        note0.bookmark = true
//                        note0.likes_count = 5
//                        note0.rating = 3.5
//                        note0.local_url = ""
//                        note0.notes_id = UUID()
//
//                        let note1 = NotesEntity(context: viewContext)
//                        note1.name = "8th Class Chemistry"
//                        note1.chapter = "All Chapters"
//                        note1.bookmark = false
//                        note1.likes_count = 15
//                        note1.rating = 4.5
//                        note1.local_url = ""
//                        note1.notes_id = UUID()
//
//                        let note2 = NotesEntity(context: viewContext)
//                        note2.name = "8th Class Chemistry"
//                        note2.chapter = "All Chapters"
//                        note2.bookmark = false
//                        note2.likes_count = 15
//                        note2.rating = 4.5
//                        note2.local_url = ""
//                        note2.notes_id = UUID()
//
//                        let note3 = NotesEntity(context: viewContext)
//                        note3.name = "8th Class Mathematics"
//                        note3.chapter = "All Chapters"
//                        note3.bookmark = false
//                        note3.likes_count = 20
//                        note3.rating = 4.0
//                        note3.local_url = ""
//                        note3.notes_id = UUID()
//
//                        let note4 = NotesEntity(context: viewContext)
//                        note4.name = "6th Class Mathematics"
//                        note4.chapter = "All Chapters"
//                        note4.bookmark = true
//                        note4.likes_count = 43
//                        note4.rating = 4.5
//                        note4.local_url = ""
//                        note4.notes_id = UUID()
//
//                        for subject in Array(subjects) {
//                            subject.addToNotes_id(note0)
//                            subject.addToNotes_id(note1)
//                            subject.addToNotes_id(note2)
//                            subject.addToNotes_id(note3)
//                            subject.addToNotes_id(note4)
//                        }
//                        saveData()
//                        savedEntities = Array(subjects)
//                    }
//                }
//            }
//        } catch {
//            print("Error fetching users: \(error.localizedDescription)")
//
//        }
//    }
    
    func saveData() {
        
        do {
            try viewContext.save()
            //fetchAllSubjects()
        }
        catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
//    func deleteAllEntities() {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesEntity")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try persistenceController.container.persistentStoreCoordinator.execute(deleteRequest, with: viewContext)
//            try viewContext.save()
//        } catch {
//            print("Error deleting entities: \(error.localizedDescription)")
//        }
//    }
    
//    func addSubjects() {
//
//        let newStandard0 = SubjectEntity(context: viewContext)
//        newStandard0.subject_id = UUID()
//        newStandard0.name = "Physics"
//        newStandard0.descrip = "Get solved notes by top professors of Pakistan"
//
//        let newStandard = SubjectEntity(context: viewContext)
//        newStandard.subject_id = UUID()
//        newStandard.name = "Chemistry"
//        newStandard.descrip = "Get solved notes by top professors of Pakistan"
//
//        let newStandard1 = SubjectEntity(context: viewContext)
//        newStandard1.subject_id = UUID()
//        newStandard1.name = "Mathematics"
//        newStandard1.descrip = "Get solved notes by top professors of Pakistan"
//
//        let newStandard2 = SubjectEntity(context: viewContext)
//        newStandard2.subject_id = UUID()
//        newStandard2.name = "Computer Science"
//        newStandard2.descrip = "Get solved notes by top professors of Pakistan"
//        saveData()
//
//    }
    
    
    
    
}
