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
    
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    init() {
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
        
        let newStandard0 = StandardEntity(context: viewContext)
        newStandard0.standard_id = UUID()
        newStandard0.name = "Matriculation"
        newStandard0.descrip = "nil"
        
        let newStandard = StandardEntity(context: viewContext)
        newStandard.standard_id = UUID()
        newStandard.name = "Intermediate"
        newStandard.descrip = "nil"
        
        let newStandard1 = StandardEntity(context: viewContext)
        newStandard1.standard_id = UUID()
        newStandard1.name = "Bachelors"
        newStandard1.descrip = "nil"
        
        saveData()
        
    }
    
    
    
}
