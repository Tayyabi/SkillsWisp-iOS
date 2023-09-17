//
//  DateSheetDataService.swift
//  SkillsWisp
//
//  Created by M Tayyab on 09/09/2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class DateSheetDataService {
    
    private let dateSheetsCollection = Firestore.firestore().collection("date_sheets")
    private let dateSheetsBookmarkCollection = Firestore.firestore().collection("date_sheet_bookmarks")
    private let userCollection = Firestore.firestore().collection("users")
    
    
    func fetchDateSheetsFromDB(completion: @escaping ([PastSubjectModel]?) -> ())  async throws {
        
        dateSheetsCollection.getDocuments { (querySnapshot, error) in
            
            if let error = error {
                print("Error fetchDateSheetsFromDB: \(error)")
                completion(nil)
                return
            }
            
            var dateSheets: [PastSubjectModel] = []
            
            for document in querySnapshot!.documents {
                let data = document.data()
                print("data", data)
                
                let dateSheet = PastSubjectModel(data: data, isSub: false)
                dateSheets.append(dateSheet)
            }
            completion(dateSheets)
            
        }
        
    }
    
    
    func addBookmarksInDB(dateSheetId: String, isBookmark: Bool) async throws {
        
        guard let user = Auth.auth().currentUser else { return }
        
        
        let bookmark = BookmarkModel(isBookmark: isBookmark, userId: user.uid)
        
        try await dateSheetsBookmarkCollection.document(dateSheetId).collection("user_id").document(user.uid).setData(from: bookmark, merge: false, encoder: Coders.encoder){ error in
            if let error = error {
                print("Error addBookmarksInDB: \(error)")
            } else {
                print("addBookmarksInDB successfully")
            }
        }
        
        
        try await userCollection.document(user.uid).collection("date_sheet_bookmarks").document(dateSheetId)
            .setData(["date_sheet_id":dateSheetId], merge: false)
    }
    
    func checkUserBookmark(dateSheetId: String) async throws -> Bool {
        
        guard let user = Auth.auth().currentUser else { throw UserError.userNotLogin }
        
        
        let subjectDocRef = dateSheetsBookmarkCollection.document(dateSheetId)
        let bookmarkDocumentSnapshot = try await subjectDocRef
                    .collection("user_id")
                    .document(user.uid)
                    .getDocument()
        
        
        if bookmarkDocumentSnapshot.exists {
            guard let data = bookmarkDocumentSnapshot.data() else { return false }
            let note = BookmarkModel(data: data)
            
            return note.isBookmark
        }
        else{
            return false
        }
        
    }
    
    
    func downloadDateSheetPastPaper(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                completion(data, nil)
            }
        }
        
        task.resume()
    }
    
    func fetchOneDateSheetFromDB(date_sheet_id: String, completion: @escaping (PastSubjectModel?) -> ()) async throws {
        
        let dateSheetDocRef = dateSheetsCollection.document(date_sheet_id)
        let dateSheetDocumentSnapshot = try await dateSheetDocRef.getDocument()
        
        
        if dateSheetDocumentSnapshot.exists {
            guard let data = dateSheetDocumentSnapshot.data() else { return }
            let dateSheet = PastSubjectModel(data: data, isSub: false)
            
            return completion(dateSheet)
        }
        else{
            return completion(nil)
        }
    }
    
}

