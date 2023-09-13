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
                
                let dateSheet = PastSubjectModel(data: data)
                dateSheets.append(dateSheet)
            }
            completion(dateSheets)
            
        }
        
    }
    
}

