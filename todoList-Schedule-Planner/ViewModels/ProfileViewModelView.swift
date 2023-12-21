//
//  ProfileViewModelView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 08/12/2023.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class ProfileViewModelView: ObservableObject {
    @StateObject private var authManager = AuthManager()
    @Published var user: User? = nil
    
    init() {}
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return  }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .getDocument {[weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else { return }
                DispatchQueue.main.async {
                    self?.user = User(id: data["id"] as? String ?? "",
                                      email: data["email"] as? String ?? "",
                                      join: data["join"] as? TimeInterval ?? Date().timeIntervalSince1970)
                }
            }
    }
    
    func logOut() {
        authManager.signOut()
    }
}
