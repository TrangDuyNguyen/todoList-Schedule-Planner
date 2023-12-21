//
//  TDSecureField.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 15/12/2023.
//

import SwiftUI

struct TDSecureField: View {
    @StateObject public var manager: TDSecureFieldManager
    @Binding public var messageError: String
    var onTextChange: ((String) -> Void)?
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 4) {
                
                HStack(spacing: 15) {
                    SecureField("", text: $manager.text)
                        .textFieldStyle(PlainTextFieldStyle())
                        .onChange(of: manager.text) { newValue in
                            // Xử lý khi giá trị của SecureField thay đổi
                            if newValue.isEmpty {
                                withAnimation(.easeOut) {
                                    manager.isTapped = false
                                }
                            } else {
                                withAnimation(.easeIn) {
                                    manager.isTapped = true
                                }
                            }
                            onTextChange?(newValue)
                        }
                    Button {
                        manager.hidePassword.toggle()
                    } label: {
                        Image(systemName: manager.hidePassword ? "eye" : "eye.slash")
                            .foregroundColor(Color("Gray"))
                    }

                }
                .padding(.top, manager.isTapped ? 15 : 0)
                .background(
                    Text(manager.placeHolder)
                        .scaleEffect(manager.isTapped ? 0.8 : 1)
                        .offset(x: manager.isTapped ? -7 : 0, y: manager.isTapped ? -15 : 0)
                        .foregroundColor(manager.isTapped ? .accentColor : Color("Gray")),
                    alignment: .leading
                )
                .padding(.horizontal)
            }
            .padding(.top, 12)
            .background(Color("Gray").opacity(0.09))
            .cornerRadius(5)
            HStack {
                Spacer()
                Text("\(manager.text.count)/15")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
        }
    }
}

class TDSecureFieldManager: ObservableObject {
    @Published public var text: String {
        didSet {
            if text.count > 15 && oldValue.count <= 15 {
                self.text = oldValue
            }
        }
    }
    
    @Published public var placeHolder: String
    @Published public var isTapped = false
    @Published public var hidePassword: Bool = true
    
    init(text: String, placeHolder: String) {
        self.text = text
        self.placeHolder = placeHolder
    }
}

struct TDSecureField_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
