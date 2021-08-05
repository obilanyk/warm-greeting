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
    var category: Category = Category.NotMentioned
    var content: String = ""
    var favourite: Bool = false
    var mark: Int = 0
    
    func getAllGreetings() {
        greetings = PersistentController.shared.getAllGreetings().map(GreetingViewModel.init)
    }
    
    func save() {
        let greeting = Greeting(context: PersistentController.shared.container.viewContext)
        greeting.name = name
        greeting.category = category.description
        greeting.content = content
        greeting.favourite = favourite
        greeting.mark = Int16(mark)
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
    
    var greetingId: String {

        guard let greetingId = self.greeting.greetingId else {
            return ""
        }

        return greetingId.uuidString

    }
    var name: String {
        return greeting.name ?? ""
    }
    var category: Category {
        return Category(rawValue: greeting.category ?? "NotMentioned") ?? .NotMentioned
    }
    var content: String {
        return greeting.content ?? ""
    }
    var favourite: Bool {
        return greeting.favourite
    }
    var mark: Int {
        return Int(greeting.mark)
    }
    
  
}



enum Category: String {
    var description: String {
        return rawValue
    }
    
    
    case Family
    case Friends
    case Colleagues
    case Other
    case NotMentioned = "Not Mentioned"
    static var all = [Category.Family, .Friends, .Colleagues, .Other]
}

//case family = "Family"
//case friends = "Friends"
//case colleagues = "Colleagues"
//case other = "Other"
