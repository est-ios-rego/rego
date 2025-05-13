//
//  Tabiew.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI

struct MainView: View {
    @SceneStorage("selectedTab") private var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView(selectedIndex: $selectedIndex)
                .tabItem {
                    Label("홈", systemImage: "house")
                }
                .tag(0)

            ListView(items: Retrospect.sampleData)
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
    }
}

#Preview {
    MainView()
}
