//
//  TaskDetailViewModelView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 12/12/2023.
//

import SwiftUI

class TaskDetailViewModelView: ObservableObject {
    @Published var task: Task
    
    init(task: Task) {
        self.task = task
    }
}

