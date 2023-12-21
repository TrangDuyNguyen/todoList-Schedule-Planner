//
//  User.swift
//  ToDoList
//
//  Created by admin on 13/09/2023.
//

import Foundation
struct User: Codable {
    let id: String
    let email: String
    let join: TimeInterval
}
