//
//  Session.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 06/12/2023.
//

import SwiftUI
import FirebaseAuth
import Combine

class Session: ObservableObject {
    static var shared = Session()
    
    // Thông tin đăng nhập
    var isLoggedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    // Các thông tin khác của ứng dụng
    var appVersion: String
    var theme: AppTheme
    
    init() {
        self.appVersion = "1.0.0"
        self.theme = .light
    }
    
}

enum AppTheme {
    case light
    case dark
}
