//
//  KeychainHelper.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 07/12/2023.
//

import SwiftUI
import SwiftKeychainWrapper

struct KeychainHelper {
    static let emailKey = "userEmail"

    static func saveUserInfo(email: String) {
        KeychainWrapper.standard.set(email, forKey: emailKey)
    }

    static func loadUserInfo() -> String? {
        return KeychainWrapper.standard.string(forKey: emailKey)
    }
    
    static func removeUserInfo() {
        KeychainWrapper.standard.removeObject(forKey: emailKey)
    }
}
