//
//  HomeViewModelView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 30/11/2023.
//

import SwiftUI

class HomeViewModelView: ObservableObject {
    @Published var activeTab: Tab = .home
    @Published var tabShapePosition: CGPoint = .zero
}
