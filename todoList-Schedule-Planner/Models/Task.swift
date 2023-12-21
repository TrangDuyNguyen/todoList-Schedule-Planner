//
//  Task.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 01/12/2023.
//

import SwiftUI

struct Task: Codable, Hashable, Identifiable {
    var id: String
    var dateAdded: TimeInterval
    var taskName: String
    var taskDescription: String
    var taskCategory: Categorite
    var taskStatus: TaskStatus
    var dueDate: TimeInterval
    var timeReminder: TimeInterval?
    var repeateTask: Bool
    var note: String
    var attachments: Attachment?
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case dateAdded
//        case taskName
//        case taskDescription
//        case taskCategory
//        case taskStatus
//        case dueDate
//        case timeReminder
//        case repeateTask
//        case note
//        case attachments
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            id = try container.decode(String.self, forKey: .id)
//            dateAdded = try container.decode(TimeInterval.self, forKey: .dateAdded)
//            taskName = try container.decode(String.self, forKey: .taskName)
//            taskDescription = try container.decode(String.self, forKey: .taskDescription)
//            taskCategory = try container.decode(Categorite.self, forKey: .taskCategory)
//            taskStatus = try container.decode(TaskStatus.self, forKey: .taskStatus)
//            dueDate = try container.decode(TimeInterval.self, forKey: .dueDate)
//            timeReminder = try container.decode(TimeInterval.self, forKey: .timeReminder)
//            repeateTask = try container.decode(Bool.self, forKey: .repeateTask)
//            note = try container.decode(String.self, forKey: .note)
//
//            // Decode attachments if present
//            attachments = try container.decodeIfPresent(Attachment.self, forKey: .attachments)
//    }
}

enum TaskStatus: String, CaseIterable, Codable {
    case notStarted
    case inProgress
    case completed
    case overdue
    case cancelled
    case onHold
    
    var color: Color {
        switch self {
            
        case .notStarted:
            return Color("Gray")
        case .inProgress:
            return Color.orange
        case .completed:
            return Color.green
        case .overdue:
            return Color.yellow
        case .cancelled:
            return Color.red
        case .onHold:
            return Color("Purple")
        }
    }
}

