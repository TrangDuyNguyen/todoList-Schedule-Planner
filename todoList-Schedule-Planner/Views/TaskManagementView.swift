//
//  TaskManagementView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 01/12/2023.
//

import SwiftUI
import FirebaseFirestoreSwift

struct TaskManagementView: View {
    @StateObject var viewModel = TaskManagementViewModelView()
    @StateObject private var authManager = AuthManager()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 15) {
                ForEach($viewModel.tasks) { $task in
                    if viewModel.selectedTab == nil || task.taskCategory.tab == viewModel.selectedTab || viewModel.selectedTab == "All" {
                        TaskRow(task)
                            .fullScreenCover(isPresented: $viewModel.seeDetail) {
                                TaskDetailView(viewModel: TaskDetailViewModelView(task: task))
                            }
                    }
                }
            }
            .padding(15)
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            HeaderView()
        }
        .onAppear() {
            viewModel.fetchTasks()
        }
        .fullScreenCover(isPresented: $viewModel.addNewTask) {
            AddTaskView(viewModel: AddTaskViewModelView(onAdd: {
                //viewModel.fetchTasks()
            }))
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Today")
                        .ubuntu(22, weight: .bold)
                    Text("Welcome, Trang")
                        .ubuntu(19, weight: .regular)
                }
                .hAlign(.leading)
                
                Button {
                    viewModel.addNewTask.toggle()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                        Text("Add Task")
                            .ubuntu(15, weight: .regular)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background {
                        Capsule()
                            .fill(Color("Blue").gradient)
                    }
                    .foregroundColor(.white)
                }
            }
            ScrollViewReader { reader in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(viewModel.categorites) { categorite in
                            Button {
                                viewModel.selectedTab = categorite.tab
                                print(viewModel.selectedTab ?? "")
                            } label: {
                                Text(categorite.tab)
                                    .ubuntu(12, weight: .regular)
                                    .padding(.vertical, 10)
                                   .padding(.horizontal)
                                   .background(Color("Blue").opacity(1))
                                    .clipShape(Capsule())
                                    .foregroundColor(.white)
                                    .id(categorite.tab)
                            }
                        }
                        .onChange(of: viewModel.selectedTab) { newValue in
                            withAnimation(.easeInOut) {
                                reader.scrollTo(newValue, anchor: .leading)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 15)
        .background{
            ZStack(alignment: .top) {
                Color.white
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func TaskRow(_ task: Task) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(task.taskName.uppercased())
                .ubuntu(16, weight: .bold)
                .foregroundColor(task.taskStatus.color)
            Text(task.taskName)
                .ubuntu(14, weight: .regular)
                .foregroundColor(task.taskStatus.color)
            if task.taskDescription != "" {
                Text(task.taskDescription)
                    .ubuntu(14, weight: .light)
                    .foregroundColor(task.taskStatus.color.opacity(0.8))
            }
        }
        .hAlign(.leading)
        .padding(12)
        .background {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color("Blue").opacity(0.8))
                    .frame(width: 4)
                Rectangle()
                    .fill(Color("Blue").opacity(0.25))
            }
        }.onTapGesture {
            viewModel.seeDetail.toggle()
        }
    }
}

struct TaskManagementView_Previews: PreviewProvider {
    static var previews: some View {
        TaskManagementView()
    }
}
