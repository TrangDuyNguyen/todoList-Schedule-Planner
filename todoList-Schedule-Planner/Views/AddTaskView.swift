//
//  AddTaskView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 04/12/2023.
//

import SwiftUI

struct AddTaskView: View {
    @StateObject private var viewModel: AddTaskViewModelView
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: AddTaskViewModelView) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
                }
                Text("Create new task")
                    .ubuntu(28, weight: .light)
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                
                TitleView("Name")
                    .padding(.top, 15)
                TextField("Task name", text: $viewModel.taskName)
                    .ubuntu(16, weight: .regular)
                    .tint(.white)
                    .foregroundColor(.white)
                    .padding(.top, 2)
                Rectangle()
                    .fill(.white.opacity(0.7))
                    .frame(height: 1)
                
                TitleView("due date")
                    .padding(.top, 15)
                HStack(alignment: .bottom, spacing: 12) {
                    HStack(spacing: 12) {
                        Text(viewModel.dueDate.toString("dd MMMM EEEE"))
                            .ubuntu(16, weight: .regular)
                            .foregroundColor(.white)
                        Image(systemName: "calendar")
                            .font(.title3)
                            .foregroundColor(.white)
                            .overlay {
                                DatePicker("", selection: $viewModel.dueDate, displayedComponents: [.date])
                                    .blendMode(.destinationOver)
                            }
                    }
                    .offset(y: -5)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                            .offset(y: 5)
                    }
                    HStack(spacing: 12) {
                        Text(viewModel.dueDate.toString("hh:mm a"))
                            .ubuntu(16, weight: .regular)
                            .foregroundColor(.white)
                        Image(systemName: "clock")
                            .font(.title3)
                            .foregroundColor(.white)
                            .overlay {
                                DatePicker("", selection: $viewModel.dueDate, displayedComponents: [.hourAndMinute])
                                    .blendMode(.destinationOver)
                            }
                    }
                    .offset(y: -5)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                            .offset(y: 5)
                    }
                }
                .padding(.bottom, 15)
            }
            .hAlign(.leading)
            .padding(15)
            .background{
                ZStack {
                    //viewModel.categorite.color
                    Color("Blue")
                    GeometryReader { geometry in
                        let size = geometry.size
                        Rectangle()
                            .fill(viewModel.animateColor)
                            .mask {
                                Circle()
                            }
                            .frame(width: viewModel.animate ? size.width*2 : 0, height: viewModel.animate ? size.height * 2 : 0)
                            .offset(viewModel.animate ? CGSize(width: -size.width / 2, height: -size.height/2) : size)
                    }
                    .clipped()
                }
                .ignoresSafeArea()
            }
            VStack(alignment: .leading, spacing: 10) {
                TitleView("Description", .gray)
                TextField("About your task", text: $viewModel.taskDescription)
                    .ubuntu(16, weight: .regular)
                    .padding(.top, 2)
                Rectangle()
                    .fill(.gray.opacity(0.7))
                    .frame(height: 1)
                
                TitleView("Task categorite", .gray)
                    .padding(.top, 15)
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 3), spacing: 15) {
                    ForEach(viewModel.categorites) { category in
                        Text(category.tab.uppercased())
                            .hAlign(.center)
                            .ubuntu(12, weight: .regular)
                            .padding(.vertical, 5)
                            .background {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    //.fill(Color("Blue").opacity(0.3))
                                    .fill(viewModel.selectedCategory == category ? Color("Blue").opacity(0.7) : Color("Blue").opacity(0.3))
                            }
                            .foregroundColor(Color("Blue"))
                            .contentShape(Rectangle())
                            .onTapGesture {
                                guard !viewModel.animate else{return}
                                viewModel.selectedCategory = category
                                viewModel.animateColor = Color("Blue")
                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1, blendDuration: 1)) {
                                    viewModel.animate = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    viewModel.animate = false
                                    viewModel.categorite = category
                                }
                            }
                    }
                }
                .padding(.top, 5)
                Button {
                    viewModel.addNewTask()
                    dismiss()
                } label: {
                    Text("Create Task")
                        .ubuntu(16, weight: .regular)
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .hAlign(.center)
                        .background {
                            Capsule()
                                .fill(viewModel.animateColor.gradient)
                        }
                }
                .vAlign(.bottom)
                .disabled(viewModel.taskName == "" || viewModel.animate)
                .opacity(viewModel.taskName == "" ? 0.6 : 1)
            }
            .padding(15)
        }
        .vAlign(.top)
    }
    
    @ViewBuilder
    func TitleView(_ value: String,_ color: Color = .white.opacity(0.7)) -> some View {
        Text(value)
            .ubuntu(12, weight: .regular)
            .foregroundColor(color)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
//        AddTaskView(viewModel: AddTaskViewModelView(onAdd: { task in
//
//        }))
        AddTaskView(viewModel: AddTaskViewModelView(onAdd: {}))
    }
}
