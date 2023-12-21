//
//  RegisterView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 30/11/2023.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModelView()
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Todo List")
                        .font(.custom("Ubuntu", size: 24))
                        .fontWeight(.bold)
                    Text("Register")
                        .font(.custom("Ubuntu", size: 22))
                        .fontWeight(.regular)
                }
                .vAlign(.top)
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Repassword", text: $viewModel.rePassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    viewModel.register()
                }) {
                    Text("Register")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .vAlign(.top)

            }
            .padding(.horizontal, 10)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
