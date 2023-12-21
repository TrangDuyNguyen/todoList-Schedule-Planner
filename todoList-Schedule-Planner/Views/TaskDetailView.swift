//
//  TaskDetailView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 12/12/2023.
//

import SwiftUI

struct TaskDetailView: View {
    @StateObject private var viewModel: TaskDetailViewModelView
    
    init(viewModel: TaskDetailViewModelView) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .contentShape(Rectangle())
                }.hAlign(.leading)

                Text("Task Detail")
                    .ubuntu(19, weight: .regular)
                    .hAlign(.center)

                Button {

                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(.black)
                        .contentShape(Rectangle())
                }.hAlign(.trailing)
            }
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.task.taskName)
                        .ubuntu(24, weight: .bold)
                        .padding(.top)
                    
                    Text(viewModel.task.taskDescription)
                        .ubuntu(16, weight: .light)
                    
                    Button {
                        
                    } label: {
                        Text(viewModel.task.taskCategory.tab)
                            .ubuntu(18, weight: .regular)
                            .foregroundColor(.white)
                            .padding(10)
                            .background {
                                Color("Blue").opacity(0.9)
                            }
                            .cornerRadius(8)
                    }
                    .hAlign(.leading)
                    buildTaskCell("calendar", title: "Due Date", content: viewModel.task.dueDate.formattedDateString("yy/MM/dd"))
                    buildTaskCell("clock", title: "Time & Reminder", content: viewModel.task.timeReminder !=  nil ? viewModel.task.timeReminder!.formattedDateString("hh:mm") : "No")
                    buildTaskCell("repeat", title: "Repeat Task", content: viewModel.task.repeateTask ? "Once" : "No")
                    Divider()
                    HStack(alignment: viewModel.task.note.isEmpty ? .center : .top) {
                        Image(systemName: "note.text")
                            .foregroundColor(Color("Gray")
                                .opacity(0.5))
                        VStack(alignment: .leading) {
                            Text("Note")
                                .ubuntu(18, weight: .regular)
                                .foregroundColor(Color("Gray")
                                    .opacity(0.5))
                            if (!viewModel.task.note.isEmpty) {
                                Text(viewModel.task.note)
                                    .ubuntu(18, weight: .regular)
                                    .foregroundColor(Color("Gray")
                                    .opacity(0.5))
                            }
                        }
                        Button {
                            
                        } label: {
                            Text("Edit")
                                .ubuntu(18, weight: .regular)
                                .foregroundColor(Color("Gray")
                                    .opacity(0.5))
                                .padding(10)
                                .background {
                                    Color("Gray").opacity(0.1)
                                }
                                .cornerRadius(8)
                        }
                        .hAlign(.trailing)
                    }
                    buildTaskCell("paperclip", title: "Attachment", content: "Add")
                }
            }

        }
        .padding(.horizontal, 15)
    }
    
    @ViewBuilder
    func buildTaskCell(_ icon: String, title: String, content: String) -> some View {
        Divider()
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color("Gray")
                    .opacity(0.5))
            Text(title)
                .ubuntu(18, weight: .regular)
                .foregroundColor(Color("Gray")
                    .opacity(0.5))
            
            Button {
                
            } label: {
                Text(content)
                    .ubuntu(18, weight: .regular)
                    .foregroundColor(Color("Gray")
                        .opacity(0.5))
                    .padding(10)
                    .background {
                        Color("Gray").opacity(0.1)
                    }
                    .cornerRadius(8)
            }
            .hAlign(.trailing)
        }.padding(.vertical, 10)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(viewModel: TaskDetailViewModelView(task: Task(id: "584F604B-C506-431B-98D3-381DB39379D5", dateAdded: 1702355895.744657, taskName: "new thank", taskDescription: "oh ho", taskCategory: Categorite(id: "BDE6049C-23AF-4E8E-A108-6824F8CF0B3F", tab: "Work"), taskStatus: .notStarted, dueDate: 1702622220, timeReminder: 1702355862.409834, repeateTask: false, note: "du")))
    }
}
