//
//  Categorite.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 04/12/2023.
//

import SwiftUI

struct Categorite: Codable, Hashable, Identifiable {
    var id: String
    var tab: String
}

var tabsItems = [
    Categorite(id: UUID().uuidString, tab: "All"),

    Categorite(id: UUID().uuidString, tab: "Work"),

    Categorite(id: UUID().uuidString, tab: "Personal"),

    Categorite(id: UUID().uuidString, tab: "Wishlist"),

    Categorite(id: UUID().uuidString, tab: "Birthday")
]
