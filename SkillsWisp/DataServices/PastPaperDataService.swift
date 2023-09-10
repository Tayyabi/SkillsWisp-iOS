//
//  PastPaperDataService.swift
//  SkillsWisp
//
//  Created by M Tayyab on 09/09/2023.
//

import Foundation

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class PastPaperDataService {
    
    private let pastPapersCollection = Firestore.firestore().collection("past_papers")
    
    
    func fetchPastPapersFromDB(completion: @escaping ([PastPaperModel]?) -> ())  async throws {
        
        pastPapersCollection.getDocuments { (querySnapshot, error) in
            
            if let error = error {
                print("Error fetchDateSheetsFromDB: \(error)")
                completion(nil)
                return
            }
            
            var pastPapers: [PastPaperModel] = []
            
            for document in querySnapshot!.documents {
                let data = document.data()
                print("data", data)
                
                let pastPaper = PastPaperModel(data: data)
                pastPapers.append(pastPaper)
            }
            completion(pastPapers)
            
        }
        
    }
    
    
    func fetchSubjectsFromDB(paperId: String, completion: @escaping ([PastSubjectModel]?) -> ())  async throws {
        
        pastPapersCollection.document(paperId).collection("subjects")
            .getDocuments { (querySnapshot, error) in
            
            if let error = error {
                print("Error fetchSubjectsFromDB: \(error)")
                completion(nil)
                return
            }
            
            var pastSubjects: [PastSubjectModel] = []
            
            for document in querySnapshot!.documents {
                let data = document.data()
                print("data", data)
                
                let pastSubject = PastSubjectModel(data: data)
                pastSubjects.append(pastSubject)
            }
            completion(pastSubjects)
            
        }
        
    }
    
}

