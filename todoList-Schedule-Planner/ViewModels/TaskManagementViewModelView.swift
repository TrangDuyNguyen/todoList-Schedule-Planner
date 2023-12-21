//
//  TaskManagementViewModelView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 01/12/2023.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class TaskManagementViewModelView : ObservableObject {
    @Published var currentDay: Date = .init()
    @Published var categorites: [Categorite] = tabsItems
    @Published var selectedTab = tabsItems.first?.tab
    @Published var addNewTask: Bool = false
    @Published var seeDetail: Bool = false
    @Published var tasks: [Task] = []
    
    init() {
            fetchTasks()
        }
    
    func fetchTasks() {
        guard let uId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uId).collection("todos").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                self.tasks.removeAll()
                for document in querySnapshot!.documents {
                    do {
                        let task = try document.data(as: Task.self)
                        self.tasks.append(task)
                    } catch {
                        print("Error decoding task: \(error.localizedDescription)")
                    }
                }
                
                // Do something with the tasks array (e.g., update your UI)
                print("Updated tasks: \(self.tasks)")
            }
        }
    }
    
}
