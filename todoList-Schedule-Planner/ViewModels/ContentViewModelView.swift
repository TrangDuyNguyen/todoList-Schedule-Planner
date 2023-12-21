//
//  ContentViewModelView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 30/11/2023.
//

import SwiftUI
import FirebaseAuth
class ContentViewModelView: ObservableObject {
    @Published var curentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    init() {
        self.handler = Auth.auth().addStateDidChangeListener {[weak self] _, user in
            DispatchQueue.main.async {
                self?.curentUserId = user?.uid ?? ""
            }
        }
    }
    public var isSignInBool: Bool {
        return Auth.auth().currentUser != nil
    }
}
