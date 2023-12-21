//
//  ContentView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 30/11/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModelView()
    var body: some View {
        if viewModel.isSignInBool, !viewModel.curentUserId.isEmpty {
            HomeView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
