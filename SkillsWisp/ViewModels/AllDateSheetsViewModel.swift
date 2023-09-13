//
//  AllDateSheetsViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 09/09/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AllDateSheetsViewModel: ObservableObject {
    
    @Published var dateSheets: [PastSubjectModel] = []
    @Published var isLoading = true
   
    
    let dateSheetDataService = DateSheetDataService()
    
    func fetchDateSheetsFromDB() async {
        try? await dateSheetDataService.fetchDateSheetsFromDB { dateSheets in
            guard let dateSheets = dateSheets else {
                return
            }
            self.dateSheets = dateSheets
        }
    }
    
    
}
