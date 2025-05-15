//
//  Tabiew.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @SceneStorage("selectedTab") private var selectedIndex = 0
    @StateObject private var toastManager = ToastManager()

    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView(selectedIndex: $selectedIndex)
                .tabItem {
                    Label("홈", systemImage: "house")
                }
                .tag(0)

            ListView()
                .tabItem {
                    Label("목록", systemImage: "list.bullet.clipboard")
                }
                .tag(1)

            StatisticsView()
                .tabItem {
                    Label("통계", systemImage: "pencil.slash")
                }
                .tag(2)

            SettingView()
                .tabItem {
                    Label("설정", systemImage: "gear")
                }
                .tag(3)
        }
        .environmentObject(toastManager)
        .modifier(ToastModifier(isPresented: $toastManager.isPresented, message: toastManager.message))
    }
}

#Preview {
    MainView()
}
