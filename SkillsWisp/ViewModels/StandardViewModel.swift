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
    @Published var data: String = ""
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    init() {
        //deleteAllEntities()
        //fetchAllSubjects()
    }
    init(data: String) {
        self.data = data
    }
    
    func fetchAllSubjects() {
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
    
    func fetchSubjectsById(id: String) {
        
        let fetchRequest: NSFetchRequest<SubjectEntity> = SubjectEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "subject_id == %@", id)
        
        do {
            
            let matchingUsers = try viewContext.fetch(fetchRequest)
            
            if matchingUsers.isEmpty {
                print("Email does not exist")
                
            } else {
                print("Email exists")
               
                if let userEntity = matchingUsers.first {
                    
//                    print("User ID: \(userEntity.user_id?.uuidString ?? "")")
//                    print("User Name: \(userEntity.full_name ?? "")")
//                    print("User Email: \(userEntity.email ?? "")")
//
//                    UserDefaults.standard.set(userEntity.user_id?.uuidString ?? "", forKey: "user_id")
//                    UserDefaults.standard.set(userEntity.full_name ?? "", forKey: "full_name")
//                    UserDefaults.standard.set(userEntity.email ?? "", forKey: "email")
//                    UserDefaults.standard.set(userEntity.phone_no ?? "", forKey: "phone_no")
                    
                }
                
            }
            
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
            
        }
        
    }
    
    func saveData() {
        
        do {
            try viewContext.save()
            fetchAllSubjects()
            
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
