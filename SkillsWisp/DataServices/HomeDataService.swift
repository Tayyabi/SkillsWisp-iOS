//
//  HomeDataService.swift
//  SkillsWisp
//
//  Created by M Tayyab on 22/07/2023.
//

import Foundation
import FirebaseFirestore

final class HomeDataService {
    
    private let standardsCollection = Firestore.firestore().collection("standards")
    
    
    
    func fetchStandardsFromDB(completion: @escaping ([StandardModel]?) -> ())  async throws {
        
        standardsCollection.getDocuments { (querySnapshot, error) in
            
            if let error = error {
                print("Error fetchStandardsFromDB: \(error)")
                completion(nil)
                return
            }
            
            var standards: [StandardModel] = []
            
            for document in querySnapshot!.documents {
                let data = document.data()
                
                print("data", data)
                
                let standard = StandardModel(standard_id: data["standard_id"] as? String ?? "UNKNOWN",
                                             name: data["name"] as? String ?? "UNKNOWN",
                                             description: data["description"] as? String ?? "UNKNOWN")
                standards.append(standard)
            }
            completion(standards)
            
        }
        
    }
    
    func fetchSubjectsFromDB(standard_id: String,completion: @escaping ([SubjectModel]?) -> ()) async throws {
        
        let subjectDocRef = standardsCollection.document(standard_id)
        let subjectsCollectionRef = subjectDocRef.collection("subjects")
        
        subjectsCollectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetchUserPosts: \(error)")
                completion(nil)
                return
            }
            
            var subjects: [SubjectModel] = []
            
            for document in querySnapshot!.documents {
                let data = document.data()
                let subject = SubjectModel(subject_id: data["subject_id"] as? String ?? "UNKNOWN",
                                           name: data["name"] as? String ?? "UNKNOWN",
                                           description: data["description"] as? String ?? "UNKNOWN")
                subjects.append(subject)
            }
            completion(subjects)
            print("Fetched subjects: \(subjects)")
        }
    }
    
    func fetchNotesFromDB(standard_id: String,subject_id: String, completion: @escaping ([NoteModel]?) -> ()) async throws {
        
        let subjectDocRef = standardsCollection.document(standard_id)
        let notesCollectionRef = subjectDocRef.collection("subjects").document(subject_id).collection("notes")
        
        notesCollectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetchUserPosts: \(error)")
                completion(nil)
                return
            }
            
            var notes: [NoteModel] = []
            
            for document in querySnapshot!.documents {
                let data = document.data()
                
                let note = NoteModel(notes_id: data["note_id"] as? String ?? "UNKNOWN", name: data["name"] as? String ?? "UNKNOWN", chapter: data["chapter"] as? String ?? "UNKNOWN", rating: data["rating"] as? Double ?? 0.0, local_url: data["url"] as? String ?? "UNKNOWN", likes_count: data["likes_count"] as? Int64 ?? 0, review_count: data["review_count"] as? Int64 ?? 0, bookmark: data["bookmark"] as? Bool ?? false,
                                     thumbnail: data["thumbnail"] as? String ?? "UNKNOWN")
                
                notes.append(note)
            }
            completion(notes)
            print("Fetched subjects: \(notes)")
        }
    }
}
