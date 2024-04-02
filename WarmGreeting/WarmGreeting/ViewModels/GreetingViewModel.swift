//
//  GreetingViewModel.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 29.07.2021.
//
import Foundation
import CoreData
import SwiftUI

enum Category: String, CaseIterable, Codable {
    var description: String {
        return rawValue
    }
    case none = "None"
    case family = "Family"
    case friends = "Friends"
    case colleagues = "Colleagues"
    case other = "Other"
}
struct GreetingViewState: Decodable {
    var name: String = ""
    var category: Category = .none
    var content: String = ""
    var favourite: Bool = false
    var mark: Int = 0
}

struct GreetingStyle {
    var bgImage: Image?
    var color: Color = .black
    var fontName: Font = .body
    var fontname: String = "Al Nile"
    var weight: Font.Weight = Font.Weight.regular
    var fontSize: Double = 20.0
}
