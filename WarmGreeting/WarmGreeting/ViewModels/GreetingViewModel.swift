//
//  GreetingViewModel.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 29.07.2021.
//
// swiftlint:disable identifier_name

import Foundation
import CoreData

class GreetingData {
    @Published  var greetings: [GreetingViewModel] = []
    init() {
        greetings = getAllGreetings()
    }

    func getAllGreetings() -> [GreetingViewModel] {
        greetings = PersistentController.shared.getAllGreetings().map(GreetingViewModel.init)
        return greetings
    }
}

class GreetingListViewModel: ObservableObject {

    @Published  var greetings: [GreetingViewModel] = []
    private let greetingData = GreetingData()

    @Published var searchText: String = "" {
        didSet {
            updateSearchFor(text: searchText, categoryType: Category.allCases[selectedSearchScopeIndex])
        }
    }

    @Published var selectedSearchScopeIndex: Int = 0 {
        didSet {
            print("Selected color: \(selectedSearchScopeIndex)")
            updateSearchFor(text: searchText, categoryType: Category.allCases[selectedSearchScopeIndex])
        }
    }

    init() {
        greetings = greetingData.greetings
    }

    func updateSearchFor(text: String, categoryType: Category) {
        guard !text.isEmpty else {
            greetings = greetingData.greetings
            return
        }
        greetings = greetingsFor(text: text, categoryType: categoryType)
    }

    func greetingsFor(text: String, categoryType: Category) -> [GreetingViewModel] {
        let lowercasedText = text.lowercased()
        var filteredGreetings = greetingData.greetings.filter {
            $0.name.lowercased().contains(lowercasedText)
                || $0.content.lowercased().contains(lowercasedText)
        }
        if categoryType != .none {
            filteredGreetings = filteredGreetings.filter { $0.category == categoryType }
        }
        return filteredGreetings
    }

    func preloadData() {
        for greeting in greetingDefaultList {
            save(greetingViewState: greeting)
        }
    }
    func update(objectId: NSManagedObjectID, greetingViewState: GreetingViewState) {
        let existingGreeting = PersistentController.shared.getById(id: objectId)
        if let greeting = existingGreeting {
            greeting.name = greetingViewState.name
            greeting.category = greetingViewState.category.description
            greeting.content = greetingViewState.content
            greeting.favourite = greetingViewState.favourite
            greeting.mark = Int16(greetingViewState.mark)
            PersistentController.shared.save { error in
                print( "error \(String(describing: error?.localizedDescription))")
            }
            getAllGreetings()
        }
    }
    func save(greetingViewState: GreetingViewState) {
        if greetingViewState.name.isEmpty && greetingViewState.content.isEmpty {
            return
        }
        let greeting = Greeting(context: PersistentController.shared.container.viewContext)
        greeting.name = greetingViewState.name
        greeting.category = greetingViewState.category.description
        greeting.content = greetingViewState.content
        greeting.favourite = greetingViewState.favourite
        greeting.mark = Int16(greetingViewState.mark)
        PersistentController.shared.save { error in
            print( "error \(String(describing: error?.localizedDescription))")
        }
        getAllGreetings()
    }

    func deleteGreeting(_ greeting: GreetingViewModel) {
        let existingGreeting = PersistentController.shared.getById(id: greeting.id)
        if let existingGreeting = existingGreeting {
            PersistentController.shared.delete(existingGreeting, completion: { error in
                print( "error \(String(describing: error?.localizedDescription))")
            })
        }
        getAllGreetings()
    }
    func getAllGreetings() {
        greetings = greetingData.getAllGreetings()

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
        return Category(rawValue: greeting.category ?? "None") ?? .none
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

enum Category: String, CaseIterable {
    var description: String {
        return rawValue
    }
    case none = "None"
    case family = "Family"
    case friends = "Friends"
    case colleagues = "Colleagues"
    case other = "Other"
}
struct GreetingViewState {
    var name: String = ""
    var category: Category = .none
    var content: String = ""
    var favourite: Bool = false
    var mark: Int = 0
}
