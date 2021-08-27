//
//  GreetingViewModel.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 29.07.2021.
//
import Foundation
import CoreData

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
