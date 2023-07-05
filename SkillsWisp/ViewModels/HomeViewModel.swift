//
//  HomeViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 02/07/2023.
//

import Foundation
import CoreData

class HomeViewModel: ObservableObject {
    
    @Published var savedEntities: [StandardEntity] = []
    @Published var data: String = ""
    
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    init() {
        //deleteAllEntities()
        //addStandard()
        fetchStandards()
    }
    
    
    func fetchStandards(){
        let fetchRequest: NSFetchRequest<StandardEntity> = StandardEntity.fetchRequest()

        do {
            let fetchedStandards = try self.viewContext.fetch(fetchRequest)

            savedEntities = fetchedStandards
            for standard in fetchedStandards {
                let name = standard.name // Access the email attribute
                let description = standard.descrip // Access other attributes
            }
        } catch {
            // Handle the error appropriately
            print("Error fetching users: \(error.localizedDescription)")
        }
    }
    
    func saveData() {
        
        do {
            try viewContext.save()
            fetchStandards()
            
        }
        catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
    func deleteAllEntities() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StandardEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try persistenceController.container.persistentStoreCoordinator.execute(deleteRequest, with: viewContext)
            try viewContext.save()
        } catch {
            print("Error deleting entities: \(error.localizedDescription)")
        }
    }
    
    func addStandard() {
        
        
        
        
        
        let newSubject0 = SubjectEntity(context: viewContext)
        newSubject0.subject_id = UUID()
        newSubject0.name = "Physics"
        newSubject0.descrip = "Get solved notes by top professors of Pakistan"
        
        let newSubject = SubjectEntity(context: viewContext)
        newSubject.subject_id = UUID()
        newSubject.name = "Chemistry"
        newSubject.descrip = "Get solved notes by top professors of Pakistan"
        
        let newSubject1 = SubjectEntity(context: viewContext)
        newSubject1.subject_id = UUID()
        newSubject1.name = "Mathematics"
        newSubject1.descrip = "Get solved notes by top professors of Pakistan"
        
        let newSubject2 = SubjectEntity(context: viewContext)
        newSubject2.subject_id = UUID()
        newSubject2.name = "Computer Science"
        newSubject2.descrip = "Get solved notes by top professors of Pakistan"
        
        
//        let newStandard0 = StandardEntity(context: viewContext)
//        newStandard0.standard_id = UUID()
//        newStandard0.name = "Matriculation"
//        newStandard0.descrip = "nil"
//        newStandard0.addToSubject_id(newSubject0)
//        newStandard0.addToSubject_id(newSubject)
//        newStandard0.addToSubject_id(newSubject1)
//        newStandard0.addToSubject_id(newSubject2)

        
        let newStandard = StandardEntity(context: viewContext)
        newStandard.standard_id = UUID()
        newStandard.name = "Intermediate"
        newStandard.descrip = "nil"
        newStandard.addToSubject_id(newSubject0)
        newStandard.addToSubject_id(newSubject)
        newStandard.addToSubject_id(newSubject1)
        newStandard.addToSubject_id(newSubject2)
        

        let newStandard1 = StandardEntity(context: viewContext)
        newStandard1.standard_id = UUID()
        newStandard1.name = "Bachelors"
        newStandard1.descrip = "nil"
        newStandard1.addToSubject_id(newSubject0)
        newStandard1.addToSubject_id(newSubject)
        newStandard1.addToSubject_id(newSubject1)
        newStandard1.addToSubject_id(newSubject2)
        
        
        saveData()
        
    }
    
    
    
}
