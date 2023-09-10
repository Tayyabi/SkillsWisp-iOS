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
    @Published var isLoading = false
    var ids: [IdsModel] = []
    
    let notesDataService = NotesDataService()
    let homeDataService = HomeDataService()
    
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
            
            await MainActor.run {
                self.isLoading = false
            }
        }
        catch {
            print("Error fetchNoteIds: \(error)")
        }
        
    }
    
    
}
