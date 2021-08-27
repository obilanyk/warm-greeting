//
//  FilteredList.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 25.08.2021.
//
// swiftlint:disable line_length
import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    let content: (T) -> Content

    var body: some View {
        List {
            ForEach(fetchRequest.wrappedValue, id: \.self) {greeting in
                self.content(greeting)
            }
            .listRowBackground(Color.clear)
            .listStyle(GroupedListStyle())
        }
    }
    init(filterValue: String, categoryIndex: Int, sortField: [NSSortDescriptor] = [], @ViewBuilder content: @escaping (T) -> Content) {
        var filter: NSPredicate?
        if !filterValue.isEmpty {
            filter = NSPredicate(format: "%K CONTAINS[cd] %@ OR %K CONTAINS[cd] %@", "name", filterValue, "content", filterValue)
            if categoryIndex != 0 {
                filter = NSPredicate(format: "(%K CONTAINS[cd] %@ OR %K CONTAINS[cd] %@) AND %K = %@", "name", filterValue, "content", filterValue, "category", Category.allCases[categoryIndex].rawValue)
            }
        }
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortField, predicate: filter)
        self.content = content
    }
}
