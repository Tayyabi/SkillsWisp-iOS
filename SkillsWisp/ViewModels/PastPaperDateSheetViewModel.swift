//
//  PastPaperDateSheetViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 13/09/2023.
//

import Foundation

import CoreData
import SwiftUI

class PastPaperDateSheetViewModel: ObservableObject {
    
    @Published var pastPaper: PastSubjectModel?
    
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    init() {
        
    }
    
    func populatePaper(paper: PastSubjectModel) {
        print("populatePaper: "+(paper.url ?? ""))
        pastPaper = paper
    }
    
}
