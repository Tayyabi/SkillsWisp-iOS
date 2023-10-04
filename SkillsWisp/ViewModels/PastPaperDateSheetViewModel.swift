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
    @Published var isLoading = false
    @Published var isLogin = false
    
    let manager = LocalFileManager.instacne
    
    let dateSheetDataService = DateSheetDataService()
    let pastPaperDataService = PastPaperDataService()
    
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    init() {
        isLogin = UserDefaults.standard.bool(forKey: "is_login")
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
    
    
    
    
    func downloadDateSheetPastPaper(paper: PastSubjectModel, isDateSheet: Bool) async {
        
        guard let url = paper.url else {
            return
        }
        
        dateSheetDataService.downloadDateSheetPastPaper(urlString: url) { (data, error) in
            
            if let error = error {
                print("Error downloading PDF: \(error.localizedDescription)")
            } else if let data = data {
                
                let name = self.manager.generateUniqueFilename()
                self.manager.saveImage(data: data, name: "\(name).pdf")
                
                self.saveDownloadedUrl(paper: paper, isDateSheet: isDateSheet)
                
            }
        }

    }
    
    func saveDownloadedUrl(paper: PastSubjectModel, isDateSheet: Bool) {
        
        let path = manager.getPathForImage(name: "\(String(describing: paper.id)).pdf")
        let download = DownloadsEntity(context: viewContext)
        download.id = paper.id
        download.local_url = path?.path
        download.name = paper.name
        download.rating = 0.0
        download.chapter = ""
        download.type = "pdf"
        download.category = isDateSheet ? "DATE_SHEET" : "PAST_PAPER"
        
        
        //self.isLoading = false
        saveData()
    }
    
    func saveData() {
        
        do {
            try viewContext.save()
            print("Saved Successfully")
        }
        catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
    
}
