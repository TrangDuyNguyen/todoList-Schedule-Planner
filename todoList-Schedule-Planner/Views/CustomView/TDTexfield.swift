//
//  TDTexfield.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 14/12/2023.
//

import SwiftUI

struct TDTexfield: View {
    @StateObject public var manager: TDManager
    @Binding public var messageError: String
    var onTextChange: ((String) -> Void)?

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 4) {
                
                HStack(spacing: 15) {
                    TextField("", text: $manager.text)
                        .onChange(of: manager.text) { newValue in
                            if newValue.isEmpty {
                                withAnimation(.easeOut) {
                                    manager.isTapped = false
                                    manager.hasButton = false
                                }
                            } else {
                                withAnimation(.easeIn) {
                                    manager.isTapped = true
                                    manager.hasButton = true
                                }
                            }
                            self.onTextChange?(newValue)
                        }
                    if manager.hasButton {
                        Button {
                            manager.text = ""
                        } label: {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(Color("Gray"))
                        }
                    }
                }
                .padding(.top, manager.isTapped ? 15 : 0)
                .background(
                    Text(manager.placeHoder)
                        .scaleEffect(manager.isTapped ? 0.8 : 1)
                        .offset(x: manager.isTapped ? -7 : 0, y: manager.isTapped ? -15 : 0)
                        .foregroundColor(manager.isTapped ? .accentColor : Color("Gray")),
                    alignment: .leading
                )
                .padding(.horizontal)
                .padding(.bottom, 15)
            }
            .padding(.top, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(manager.isTapped ? .accentColor : Color("Gray").opacity(0.09), lineWidth: 1)
            )
            HStack {
                Text(messageError)
                    .font(.caption)
                    .foregroundColor(.red)
                Spacer()
                Text("\(manager.text.count)/45")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 5)
        }
    }
}

class TDManager: ObservableObject {
    @Published public var text: String = "" {
        didSet {
            if text.count > 45 && oldValue.count <= 45 {
                self.text = oldValue
            }
        }
    }
    @Published public var hasButton: Bool = false
    @Published public var placeHoder: String
    @Published public var isTapped = false

    init(placeHoder: String, text: String = "") {
        self.placeHoder = placeHoder
        self.text = text
    }
}

struct TDTexfield_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
