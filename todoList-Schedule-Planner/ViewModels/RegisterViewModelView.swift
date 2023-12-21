//
//  RegisterViewModelView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 30/11/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModelView: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var rePassword = ""
    @Published var errorMessage = ""
    @StateObject private var authManager = AuthManager()
    init() {}
    
    func validate() -> Bool {
        // Kiểm tra email và mật khẩu trước
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !rePassword.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Email, password, or re-entered password is empty"
            return false
        }

        // Kiểm tra định dạng email
        if !validateEmail(email) {
            errorMessage = "Invalid email format"
            return false
        }

        // Kiểm tra mật khẩu có ít nhất 8 ký tự
        if validatePassword(password) {
            errorMessage = "Password must be at least 8 characters"
            return false
        }

        // Kiểm tra mật khẩu nhập lại
        if password != rePassword {
            errorMessage = "Passwords do not match"
            return false
        }

        errorMessage = ""
        return true
    }

    func register() {
        if validate() {
            // Thực hiện đăng ký ở đây
            authManager.signUp(email: email, password: password)
        }
    }
    
    func insertUserRecode(id: String) {
        let user = User(id: id,
                        email: email,
                        join: Date().timeIntervalSince1970)
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(user.asDictionary())
    }

    // Hàm kiểm tra định dạng email và kiểm tra mật khẩu có thể sử dụng lại từ ví dụ trước
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func validatePassword(_ password: String) -> Bool {
        if password.count < 8 {
            return false
        }
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        let numberRegex = ".*[0-9]+.*"
        return NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex).evaluate(with: password) && NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: password)
    }
}
