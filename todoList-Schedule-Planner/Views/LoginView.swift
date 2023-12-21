//
//  LoginView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 30/11/2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModelView()
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Todo List")
                        .font(.custom("Ubuntu", size: 24))
                        .fontWeight(.bold)
                    Text("Login")
                        .font(.custom("Ubuntu", size: 22))
                        .fontWeight(.regular)
                }
                .vAlign(.top)
                
                TDTexfield(manager: TDManager(placeHoder: "Email", text: viewModel.email),
                           messageError: $viewModel.errorMessage) { newText in
                    viewModel.email = newText
                }
                
                TDSecureField(manager: .init(text: viewModel.password, placeHolder: "Password"),
                              messageError:  $viewModel.errorMessage) { newText in
                    viewModel.password = newText
                }
                
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Login")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .vAlign(.top)
                .hAlign(.center)
                
                VStack {
                    Text("New Account here?")
                        .foregroundColor(.black)
                        .hAlign(.center)
                    NavigationLink("Create an account") {
                        RegisterView()
                    }
                }.padding(.bottom, 50)
                Spacer()
                
            }
            .padding(.horizontal, 10)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
