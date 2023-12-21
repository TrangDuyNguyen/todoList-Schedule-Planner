//
//  Tab.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 30/11/2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "Tasks"
    case services = "Calender"
    case partners = "Mine"
    
    var systemImage: String {
        switch self {
        case .home:
            return "rectangle.and.pencil.and.ellipsis.rtl"
        case .services:
            return "calendar"
        case .partners:
            return "person.fill"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}

struct PositionKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func viewPosition(completion: @escaping (CGRect) -> ()) -> some View {
        self.overlay {
            GeometryReader {
                let rect = $0.frame(in: .global)
                Color.clear
                    .preference(key: PositionKey.self, value: rect)
                    .onPreferenceChange(PositionKey.self, perform: completion)
            }
        }
    }
}

struct TabShape: Shape {
    var midPoint: CGFloat
    var animatableData: CGFloat {
        get {
            midPoint
        }
        set {
            midPoint = newValue
        }
    }
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.addPath(Rectangle().path(in: rect))
            
            path.move(to: .init(x: midPoint - 60, y: 0))
            
            let to = CGPoint(x: midPoint, y: -25)
            let control1 = CGPoint(x: midPoint - 25, y: 0)
            let control2 = CGPoint(x: midPoint - 25, y: -25)
            path.addCurve(to: to, control1: control1, control2: control2)
            
            let to1 = CGPoint(x: midPoint + 60, y: 0)
            let control3 = CGPoint(x: midPoint + 25, y: -25)
            let control4 = CGPoint(x: midPoint + 25, y: 0)
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}
