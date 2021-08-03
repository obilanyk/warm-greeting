//
//  GreetingViewModel.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 29.07.2021.
//

import Foundation

import CoreData

class GreetingListViewModel: ObservableObject {
   
    @Published  var greetings: [GreetingViewModel] = []
    
//    @Published var tasks: [GreetingViewModel] = []
    
    var name: String  = ""
    var category: String = ""
    var content: String = ""
    var favourite: Bool = false
    var mark: Double = 0.0
    
    func getAllGreetings() {
        greetings = PersistentController.shared.getAllGreetings().map(GreetingViewModel.init)
    }
    
    func save() {
        let greeting = Greeting(context: PersistentController.shared.container.viewContext)
        greeting.name = name
        greeting.category = category
        greeting.content = content
        greeting.favourite = favourite
        greeting.mark = mark
        PersistentController.shared.save(){error in
            print(error?.localizedDescription)
        }
    }
    
    func deleteGreeting(_ greeting: GreetingViewModel) {
//        var deleted = false
        let existingGreeting = PersistentController.shared.getById(id: greeting.id)
        if let existingGreeting = existingGreeting {
            PersistentController.shared.delete(existingGreeting, completion: {error in
                print(error?.localizedDescription)
            })
        }
        
       
        
    }
}

class GreetingViewModel {
    
    let greeting: Greeting
    init(greeting: Greeting) {
        self.greeting = greeting
    }
    
    var id: NSManagedObjectID {
        return greeting.objectID
    }
    var name: String {
        return greeting.name ?? ""
    }
    var category: String {
        return greeting.category ?? ""
    }
    var content: String {
        return greeting.content ?? ""
    }
    var favourite: Bool {
        return greeting.favourite
    }
    var mark: Double {
        return greeting.mark
    }
    
}
