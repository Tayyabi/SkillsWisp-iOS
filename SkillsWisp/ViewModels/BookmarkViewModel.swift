//
//  BookmarkViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 19/08/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class BookmarkViewModel: ObservableObject {
    
    @Published var notes: [NoteModel] = []
    @Published var pastPapers: [PastSubjectModel] = []
    @Published var dateSheets: [PastSubjectModel] = []
    @Published var isLoading = false
    var ids: [IdsModel] = []
    var idsPastPaper: [IdsPastPaperModel] = []
    var idsDateSheet: [String] = []
    
    let notesDataService = NotesDataService()
    let homeDataService = HomeDataService()
    let pastPaperDataService = PastPaperDataService()
    let dateSheetDataService = DateSheetDataService()
    
    func fetchNotes() async {
        
        do {
           
            guard let fetchedIds = try await notesDataService.fetchUserBookmarkNoteId() else {
                return
            }
            
            ids.append(contentsOf: fetchedIds)
            for id in ids {
                try await notesDataService.fetchOneNoteFromDB(standard_id: id.standard_id, subject_id: id.subject_id, note_id: id.note_id,
                                                           completion: { [weak self] note in
                    
                    guard let note = note else {
                        return
                    }
                    self?.notes.append(note)
                    
                })
            }
           
        }
        catch {
            print("Error fetchNoteIds: \(error)")
        }
        
    }
    
    func fetchPastPapers() async {
        
        do {
           
            guard let fetchedIds = try await notesDataService.fetchUserBookmarkPastPaperId() else {
                return
            }
            
            idsPastPaper.append(contentsOf: fetchedIds)
            for id in idsPastPaper {
                
                guard let paperId = id.past_paper_id,
                      let subjectId = id.subject_id else {
                    return
                }
                
                try await pastPaperDataService.fetchOnePastPaperFromDB(past_paper_id: paperId, subject_id: subjectId,
                                                                       completion: { [weak self] paper in
                    
                    guard let paper = paper else {
                        return
                    }
                    self?.pastPapers.append(paper)
                    
                })
            }
           
        }
        catch {
            print("Error fetchNoteIds: \(error)")
        }
        
    }
    
    
    func fetchDateSheets() async {
        
        do {
           
            guard let fetchedIds = try await notesDataService.fetchUserBookmarkDateSheetId() else {
                return
            }
            
            idsDateSheet.append(contentsOf: fetchedIds)
            for id in idsDateSheet {
                
                try await dateSheetDataService.fetchOneDateSheetFromDB(date_sheet_id: id,
                                                                       completion: { [weak self] dateSheet in
                    
                    guard let dateSheet = dateSheet else {
                        return
                    }
                    self?.dateSheets.append(dateSheet)
                    
                })
            }
            
            await MainActor.run {
                self.isLoading = false
            }
        }
        catch {
            print("Error fetchNoteIds: \(error)")
        }
        
    }
    
    
}
