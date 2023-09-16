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
    @Published var isBookmark: Bool = false
    
    let dateSheetDataService = DateSheetDataService()
    let pastPaperDataService = PastPaperDataService()
    
    
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
    
    
    func addBookmark(dateSheetId: String, isBookmark: Bool) async {
        
        do {
           
            try await dateSheetDataService.addBookmarksInDB(dateSheetId: dateSheetId, isBookmark: isBookmark)
        }
        catch{
            print("Error addBookmark: \(error)")
        }
        
    }
    
    func isBookmarked(dateSheetId: String) async {
        do {
            let isBookmark = try await dateSheetDataService.checkUserBookmark(dateSheetId: dateSheetId)
            
            await MainActor.run {
                self.isBookmark = isBookmark
            }
        }
        catch {
            print("Error isLiked: \(error)")
        }
    }
    
    
    
    func addBookmarkPastPaper(pastPaperId: String, subjectId: String, isBookmark: Bool) async {
        
        do {
            try await pastPaperDataService.addBookmarksInDB(pastPaperId: pastPaperId, subjectId: subjectId, isBookmark: isBookmark)
        }
        catch{
            print("Error addBookmark: \(error)")
        }
        
    }
    
    func isBookmarkedPastPaper(subjectId: String) async {
        do {
            let isBookmark = try await pastPaperDataService.checkUserBookmark(subjectId: subjectId)
            
            await MainActor.run {
                self.isBookmark = isBookmark
            }
        }
        catch {
            print("Error isLiked: \(error)")
        }
    }
    
}
