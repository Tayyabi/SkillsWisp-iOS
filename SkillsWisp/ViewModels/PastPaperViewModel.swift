//
//  PastPaperViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 09/09/2023.
//

import Foundation


class PastPaperViewModel: ObservableObject {
    
    //@Published var pastPapers: [PastPaperModel] = []
    
    @Published var matric: [PastPaperModel] = []
    @Published var intermediate: [PastPaperModel] = []
    @Published var bachelors: [PastPaperModel] = []
    @Published var isLoading = true
    
    
    let pastPaperDataService = PastPaperDataService()
    
    func fetchPastPapersFromDB() async {
        try? await pastPaperDataService.fetchPastPapersFromDB { pastPapers in
            guard let pastPapers = pastPapers else {
                return
            }
            
            self.matric.removeAll()
            self.intermediate.removeAll()
            self.bachelors.removeAll()
            for paper in pastPapers {
                
                switch paper.standard {
                case 0:
                    self.matric.append(paper)
                case 1:
                    self.intermediate.append(paper)
                case 2:
                    self.bachelors.append(paper)
                default: break
                    
                }
            }
        }
    }
    
    
}
