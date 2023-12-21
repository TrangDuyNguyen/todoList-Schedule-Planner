//
//  AddTaskViewModelView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 05/12/2023.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class AddTaskViewModelView: ObservableObject {
    // Closure để thêm công việc
    var onAdd: () -> Void
    
    // Các thuộc tính với giá trị mặc định
    @Published var taskName: String = ""
    @Published var taskDescription: String = ""
    @Published var taskDate: Date = Date()
    @Published var taskStatus: TaskStatus = .notStarted
    @Published var categorites: [Categorite] = tabsItems
    @Published var categorite: Categorite = tabsItems.first!
    @Published var selectedCategory: Categorite?
    @Published var dueDate: Date = Date()
    @Published var timeReminder: Date = Date()
    @Published var repeatTask: Bool = false
    @Published var note: String = ""
    
    // Thuộc tính cho animation
    @Published var animateColor: Color = Color("Blue")
    @Published var animate: Bool = false
    
    init(onAdd: @escaping () -> Void) {
        self.onAdd = onAdd
    }
    
    var canSave : Bool {
        guard !taskName.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard taskDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
    
    func addNewTask() {
        guard canSave else {
            return
        }
        guard let uId = Auth.auth().currentUser?.uid else { return }
        let newId = UUID().uuidString
        let item = Task(id: newId,
                        dateAdded: Date().timeIntervalSince1970,
                        taskName: taskName,
                        taskDescription: taskDescription,
                        taskCategory: categorite,
                        taskStatus: .notStarted,
                        dueDate: dueDate.timeIntervalSince1970,
                        timeReminder: timeReminder.timeIntervalSince1970,
                        repeateTask: repeatTask,
                        note: note,
                        attachments: Attachment(id: UUID().uuidString,
                                                filename: "",
                                                fileUrl: ""))
        
        let db = Firestore.firestore()
        let taskRef = db.collection("users").document(uId).collection("todos").document(newId)
        
        taskRef.setData(item.asDictionary()) { error in
            if let error = error {
                print("Error adding task: \(error.localizedDescription)")
            } else {
                // Thêm thành công, gọi onAdd
                self.onAdd()
            }
        }
    }
}
