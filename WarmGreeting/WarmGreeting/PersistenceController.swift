//
//  PersistenceController.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 28.07.2021.
//

import CoreData

struct PersistentController {
    static let shared = PersistentController()
    let container: NSPersistentContainer
    
   private init() {
        container = NSPersistentContainer(name: "Wish")
        container.loadPersistentStores { NSEntityDescription, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription )")
            }
        }
    }
   
    func save(completion: @escaping (Error?) ->() = {_ in}) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion:  @escaping (Error?) ->() = {_ in})  {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
    
    func getById(id: NSManagedObjectID) -> Greeting? {
        let context = container.viewContext
        do {
            return try context.existingObject(with: id) as? Greeting
        } catch {
            return nil
        }
        
    }
    func getById(greetingId: UUID, completion:  @escaping (Error?) ->() = {_ in}) -> Greeting? {
        let context = container.viewContext
        
        let request: NSFetchRequest<Greeting> = Greeting.fetchRequest()
        request.predicate = NSPredicate(format: "greetingId = %@", (greetingId.uuidString))
        
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
        
    }
    
   
    
    func getAllGreetings() -> [Greeting] {
        let fetchGreetingRequest: NSFetchRequest<Greeting> = Greeting.fetchRequest()
        let context = container.viewContext
        do {
           return try context.fetch(fetchGreetingRequest)
        } catch {
            return []
        }
    }
}
