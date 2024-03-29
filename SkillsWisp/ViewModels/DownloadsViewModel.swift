//
//  DownloadsViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 05/09/2023.
//

import Foundation
import CoreData
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class DownloadsViewModel: ObservableObject {
    
    @Published var notes: [NoteModel] = []
    @Published var dateSheets: [NoteModel] = []
    @Published var pastPapers: [NoteModel] = []
    @Published var isLoading = false
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    
    func getDownloadedNotes() async {
        
        do {
           
            
            await MainActor.run {
                self.isLoading = false
            }
        }
        catch {
            print("Error fetchNoteIds: \(error)")
        }
        
    }
    
    
    func fetchStandards(){
        let fetchRequest: NSFetchRequest<DownloadsEntity> = DownloadsEntity.fetchRequest()
        
        do {
            let fetchedDownloads = try self.viewContext.fetch(fetchRequest)
            
            for download in fetchedDownloads {
                if (download.category == "NOTE") {
                    notes.append(NoteModel(noteId: download.id ?? "UnKnown", name: download.name, chapter: download.chapter, rating: download.rating, localUrl: download.local_url, likesCount: 0, reviewCount: 0, bookmark: false, thumbnail: ""))
                }
                else if (download.category == "DATE_SHEET") {
                    dateSheets.append(NoteModel(noteId: download.id ?? "UnKnown", name: download.name, chapter: download.chapter, rating: download.rating, localUrl: download.local_url, likesCount: 0, reviewCount: 0, bookmark: false, thumbnail: ""))
                }
                else if (download.category == "PAST_PAPER") {
                    pastPapers.append(NoteModel(noteId: download.id ?? "UnKnown", name: download.name, chapter: download.chapter, rating: download.rating, localUrl: download.local_url, likesCount: 0, reviewCount: 0, bookmark: false, thumbnail: ""))
                }
            }
        } catch {
            print("Error fetchStandards: \(error.localizedDescription)")
        }
    }
    
    
}
