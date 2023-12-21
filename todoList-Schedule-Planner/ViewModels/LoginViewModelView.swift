//
//  LoginViewModelView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 30/11/2023.
//

import SwiftUI
import FirebaseAuth

class LoginViewModelView: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @StateObject private var authManager = AuthManager()
    init() {}
    
    func login() {
        // Kiểm tra email và mật khẩu trước
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
            !password.trimmingCharacters(in: .whitespaces).isEmpty
            else {
                errorMessage = "Email or password is empty"
                return
            }

        // Kiểm tra định dạng email
        if !validateEmail(email) {
            errorMessage = "Invalid email format"
            return
        }

        // Kiểm tra mật khẩu
        if !validatePassword(password) {
            errorMessage = "Invalid password format"
            return
        }

        // Nếu tất cả điều kiện đều thỏa mãn, thực hiện đăng nhập ở đây
        authManager.signIn(email: email, password: password)
        print("Đăng nhập thành công")
        errorMessage = ""
    }
    
    func validateEmail(_ email: String) -> Bool {
        // Biểu thức chính quy để kiểm tra định dạng email
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func validatePassword(_ password: String) -> Bool {
        // Kiểm tra mật khẩu có ít nhất 5 ký tự
        if password.count < 5 {
            return false
        }
        
        // Kiểm tra xem mật khẩu có ít nhất một ký tự số
        let numberRegex = ".*[0-9]+.*"
        return NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: password)
    }
}
