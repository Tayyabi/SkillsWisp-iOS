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
                
                let standard = StandardModel(data: data)
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
                let subject = SubjectModel(data: data)
                subjects.append(subject)
            }
            print("Fetched subjects: \(subjects)")
            completion(subjects)
           
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
                
                let note = NoteModel(data: data)
                
                notes.append(note)
            }
            print("Fetched subjects: \(notes)")
            completion(notes)
           
        }
    }
}
