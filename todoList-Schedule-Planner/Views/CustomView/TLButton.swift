//
//  TLButton.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 08/12/2023.
//

import SwiftUI

struct TLButton: View {
    
    var title: String
    var bgColor: Color
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(bgColor)
                
                Text(title).foregroundColor(.white)
                    .font(.system(size: 15))
                    .bold()
            }
        }
    }
}

struct TLButton_Previews: PreviewProvider {
    static var previews: some View {
        TLButton(title: "Button", bgColor: .blue) {
            
        }
    }
}

