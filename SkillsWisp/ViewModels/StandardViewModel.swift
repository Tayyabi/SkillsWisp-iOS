//
//  StandardViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 02/07/2023.
//

import Foundation
import CoreData

class StandardViewModel: ObservableObject {
    
    @Published var savedEntities: [SubjectEntity] = []
    
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    init() {
        fetchSubjects()
    }
    
    func fetchSubjects(){
        let fetchRequest: NSFetchRequest<SubjectEntity> = SubjectEntity.fetchRequest()

        do {
            let fetchedSubjects = try self.viewContext.fetch(fetchRequest)

            savedEntities = fetchedSubjects
            for subject in fetchedSubjects {
                let name = subject.name
                let description = subject.descrip
            }
            
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
    }
    
    func saveData() {
        
        do {
            try viewContext.save()
            fetchSubjects()
            
        }
        catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
    func deleteAllEntities() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SubjectEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try persistenceController.container.persistentStoreCoordinator.execute(deleteRequest, with: viewContext)
            try viewContext.save()
        } catch {
            print("Error deleting entities: \(error.localizedDescription)")
        }
    }
    
    func addSubjects() {
        
        let newStandard0 = SubjectEntity(context: viewContext)
        newStandard0.subject_id = UUID()
        newStandard0.name = "Physics"
        newStandard0.descrip = "Get solved notes by top professors of Pakistan"
        
        let newStandard = SubjectEntity(context: viewContext)
        newStandard.subject_id = UUID()
        newStandard.name = "Chemistry"
        newStandard.descrip = "Get solved notes by top professors of Pakistan"
        
        let newStandard1 = SubjectEntity(context: viewContext)
        newStandard1.subject_id = UUID()
        newStandard1.name = "Mathematics"
        newStandard1.descrip = "Get solved notes by top professors of Pakistan"
        
        let newStandard2 = SubjectEntity(context: viewContext)
        newStandard2.subject_id = UUID()
        newStandard2.name = "Computer Science"
        newStandard2.descrip = "Get solved notes by top professors of Pakistan"
        saveData()
        
    }
    
    
    
    
}
