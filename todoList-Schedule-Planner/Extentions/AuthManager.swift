//
//  AuthManager.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 07/12/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class AuthManager: ObservableObject {
    @Published var currentUser: User?
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let userid = authResult?.user.uid, error == nil else {
                print(error?.localizedDescription ?? "Error during sign up")
                return
            }

            // Save user info to Firestore
            self.insertUserRecode(id: userid, email: email)

            // Save user info to Keychain
            KeychainHelper.saveUserInfo(email: email)
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard let userid = authResult?.user.uid, error == nil else {
                print(error?.localizedDescription ?? "Error during sign in")
                return
            }
            let db = Firestore.firestore()
            db.collection("users")
                .document(userid)
                .getDocument { document, error in
                    guard let document = document, document.exists else {
                        print("User not found in Firestore")
                        return
                    }
                    if let email = document["email"] as? String {
                        // Save user info to Keychain
                        KeychainHelper.saveUserInfo(email: email)
                    }
                }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            // Xóa thông tin trên Keychain khi đăng xuất
            KeychainHelper.removeUserInfo()
            currentUser = nil
        } catch {
            print("Error during sign out: \(error.localizedDescription)")
        }
    }
    
    func insertUserRecode(id: String, email: String) {
        let user = User(id: id,
                        email: email,
                        join: Date().timeIntervalSince1970)
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(user.asDictionary())
    }
}
