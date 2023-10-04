//
//  HomeViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 02/07/2023.
//

import Foundation
import CoreData

class HomeViewModel: ObservableObject {
    
    @Published var savedEntities: [StandardModel] = []
    @Published var data: String = ""
    @Published var isLogin = false
    
    let homeDataService = HomeDataService()
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    init() {
        isLogin = UserDefaults.standard.bool(forKey: "is_login") 
        //deleteAllEntities()
        //addStandard()
        //fetchStandards()
    }
    
    
    func fetchStandardsFromDB() async {
        try? await homeDataService.fetchStandardsFromDB { standards in
            guard let standards = standards else {
                return
            }
            self.savedEntities = standards
        }
    }
    
    func fetchStandards(){
        let fetchRequest: NSFetchRequest<StandardEntity> = StandardEntity.fetchRequest()
        
        do {
            let fetchedStandards = try self.viewContext.fetch(fetchRequest)
            
            for standard in fetchedStandards {
                savedEntities.append(StandardModel(standardId: standard.standard_id?.uuidString, name: standard.name, description: standard.descrip))
            }
        } catch {
            print("Error fetchStandards: \(error.localizedDescription)")
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
