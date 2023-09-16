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
    private let pastPapersBookmarkCollection = Firestore.firestore().collection("past_papers_bookmarks")
    private let userCollection = Firestore.firestore().collection("users")
    
    
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
                
                let pastSubject = PastSubjectModel(data: data, isSub: true)
                pastSubjects.append(pastSubject)
            }
            completion(pastSubjects)
            
        }
        
    }
    
    
    
    func addBookmarksInDB(pastPaperId: String,subjectId: String, isBookmark: Bool) async throws {
        
        guard let user = Auth.auth().currentUser else { return }
        
        
        /*let bookmark = BookmarkModel(isBookmark: isBookmark, userId: user.uid)
        
        try await pastPapersBookmarkCollection.document(pastPaperId).collection("user_id").document(user.uid).setData(from: bookmark, merge: false, encoder: Coders.encoder){ error in
            if let error = error {
                print("Error addBookmarksInDB: \(error)")
            } else {
                print("addBookmarksInDB successfully")
            }
        }*/
        
        
        try await userCollection.document(user.uid).collection("past_papers_bookmarks").document(subjectId)
            .setData(["subject_id":subjectId,
                      "past_paper_id":pastPaperId,
                      "is_bookmark":isBookmark], merge: false)
    }
    
    func checkUserBookmark(subjectId: String) async throws -> Bool {
        
        guard let user = Auth.auth().currentUser else { throw UserError.userNotLogin }
        
        
        let subjectDocRef = userCollection.document(user.uid)
        let bookmarkDocumentSnapshot = try await subjectDocRef
                    .collection("past_papers_bookmarks")
                    .document(subjectId)
                    .getDocument()
        
        
        if bookmarkDocumentSnapshot.exists {
            guard let data = bookmarkDocumentSnapshot.data() else { return false }
            return true
        }
        else{
            return false
        }
        
    }
    
}

