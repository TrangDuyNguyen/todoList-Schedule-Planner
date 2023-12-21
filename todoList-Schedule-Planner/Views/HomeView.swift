//
//  HomeView.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 30/11/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModelView()
    @Namespace public var animation
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            TabView(selection: $viewModel.activeTab) {
                TaskManagementView().tag(Tab.home)
                Text("Calendar").tag(Tab.services)
                ProfileView().tag(Tab.partners)
            }
            CustomTabBar()
        }
    }
    
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color("Blue"), _ inactiveTint: Color = .blue) -> some View {
        HStack(alignment: .bottom ,spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { index in
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: index,
                    animation: animation,
                    activeTab: $viewModel.activeTab,
                    position: $viewModel.tabShapePosition)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(content: {
            TabShape(midPoint: viewModel.tabShapePosition.x)
                .fill(.white)
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .padding(.top, 25)
        })
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: viewModel.activeTab)
    }
}

struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @State private var tabPositon: CGPoint = .zero
    @Binding var activeTab: Tab
    @Binding var position: CGPoint
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            self.tabPositon.x = rect.midX

            if activeTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activeTab = tab
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = tabPositon.x
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
