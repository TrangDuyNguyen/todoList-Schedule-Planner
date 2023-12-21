//
//  ProfileView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 08/12/2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject public var viewModel = ProfileViewModelView()
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                if let user = viewModel.user {
                    Text("Profile")
                        .ubuntu(22, weight: .regular)
                    //Avatar
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.blue)
                        .frame(width: 125, height: 125)
                        .padding()
                    //info
                    VStack(alignment: .leading) {
                        HStack {
                            Text("ID: ")
                                .bold()
                            Text(user.id)
                        }.padding()
                        HStack {
                            Text("Email: ")
                                .bold()
                            Text(user.email)
                        }.padding()
                    }
                    //sign out
                    TLButton(title: "Sign out",
                             bgColor: .red) {
                        //action
                        viewModel.logOut()
                    }.frame(width: 125, height: 40)
                        .padding()
                    Spacer()
                } else {
                    Text("Profile is loading ...")
                }

            }.navigationTitle("Profile")
        }.onAppear{
            viewModel.fetchUser()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
