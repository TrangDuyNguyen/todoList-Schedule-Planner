//
//  todoList_Schedule_PlannerApp.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 30/11/2023.
//

import SwiftUI
import FirebaseCore
@main
struct todoList_Schedule_PlannerApp: App {
    init (){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
