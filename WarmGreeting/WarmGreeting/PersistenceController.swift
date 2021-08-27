//
//  PersistenceController.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 28.07.2021.
//
// swiftlint:disable void_return  identifier_name
import CoreData

struct PersistentController {
    static let shared = PersistentController()
    let container: NSPersistentContainer

   private init() {
        container = NSPersistentContainer(name: "Wish")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription )")
            }
        }
    }

    func save(completion: @escaping (Error?) -> () = {_ in}) {
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
    func update(completion: @escaping (Error?) -> () = {_ in}) {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
                completion(nil)
            } catch {
                container.viewContext.rollback()
                completion(error)
            }
        }
    }
    func delete(_ object: NSManagedObject, completion:  @escaping (Error?) -> () = {_ in}) {
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

    func getAllGreetings(with predicate: NSPredicate?) -> [Greeting] {
        let fetchGreetingRequest: NSFetchRequest<Greeting> = Greeting.fetchRequest()
        if let predicate = predicate {
            fetchGreetingRequest.predicate = predicate
        }
        let context = container.viewContext
        do {
            return try context.fetch(fetchGreetingRequest)
        } catch {
            return []
        }
    }

    func createGreeting(with greetingViewState: GreetingViewState) {
        if greetingViewState.name.isEmpty && greetingViewState.content.isEmpty {
            return
        }
        let greeting = Greeting(context: container.viewContext)
        greeting.objectWillChange.send()
               greeting.name = greetingViewState.name
               greeting.category = greetingViewState.category.description
               greeting.content = greetingViewState.content
               greeting.favourite = greetingViewState.favourite
               greeting.mark = Int16(greetingViewState.mark)
               save { error in
                   print( "error \(String(describing: error?.localizedDescription))")
               }
    }
    func  initGreetingWithDefaultData() {
        for greeting in greetingDefaultList {
            createGreeting(with: greeting)
        }
    }
}
