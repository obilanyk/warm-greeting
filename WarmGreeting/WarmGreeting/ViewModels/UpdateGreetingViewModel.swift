//
//  UpdateGreetingViewModel.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 03.08.2021.
//

import Foundation
import CoreData
class UpdateGreetingViewModel: ObservableObject {
    
    func update( id: NSManagedObjectID, greetingViewState: GreetingViewState) {
        
        let existingGreeting = PersistentController.shared.getById(id: id)
        if let greeting = existingGreeting {
            greeting.name = greetingViewState.name
            greeting.category = greetingViewState.category.description
            greeting.content = greetingViewState.content
            greeting.favourite = greetingViewState.favourite
            greeting.mark = Int16(greetingViewState.mark)
            PersistentController.shared.save(){error in
                print( "error \(error?.localizedDescription)")
            }
        }
    }
    
}

struct GreetingViewState {
    var greetingId: String = ""
    var name: String = ""
    var category: Category = .NotMentioned
    var content: String = ""
    var favourite: Bool = false
    var mark: Int = 0
    
}



