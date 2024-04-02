//
//  Greeting+CoreDataProperties.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 25.08.2021.
//
//

import Foundation
import CoreData

extension Greeting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Greeting> {
        return NSFetchRequest<Greeting>(entityName: "Greeting")
    }

    @NSManaged public var category: String?
    @NSManaged public var content: String?
    @NSManaged public var favourite: Bool
    @NSManaged public var greetingId: UUID?
    @NSManaged public var mark: Int16
    @NSManaged public var name: String?

//    var wrappedCategory: String {
//        category ?? ""
//    }

    var wrappedContent: String {
        content ?? ""
    }
    var wrappedName: String {
        name ?? "Unknown"
    }
    var wrappedCategory: Category {
        return Category(rawValue: category ?? "None") ?? .none
    }
    var wrappedMark: Int {
        return Int(mark)
    }

}

extension Greeting: Identifiable {

}
