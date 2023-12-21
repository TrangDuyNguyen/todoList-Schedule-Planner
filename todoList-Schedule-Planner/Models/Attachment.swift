//
//  Attachment.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 12/12/2023.
//

import SwiftUI

struct Attachment: Codable, Hashable, Identifiable {
    var id: String
    var filename: String
    var fileUrl: String
}
