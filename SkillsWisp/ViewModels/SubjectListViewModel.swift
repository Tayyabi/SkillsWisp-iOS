//
//  SubjectListViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 10/09/2023.
//

import Foundation

class SubjectListViewModel: ObservableObject {
    
    
    @Published var subjects: [PastSubjectModel] = []
    @Published var isLoading = true
    
    
    let pastPaperDataService = PastPaperDataService()
    
    func fetchSubjectsFromDB(paperId: String) async {
        
        print("fetchSubjectsFromDB: \(paperId)")
        
        try? await pastPaperDataService.fetchSubjectsFromDB(paperId: paperId,
                                                            completion: { subjects in
            
            guard let subjects = subjects else {
                return
            }
            
            self.subjects.removeAll()
            self.subjects.append(contentsOf: subjects)
            
        })
    }
    
    
}
